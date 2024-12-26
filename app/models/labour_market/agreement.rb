class LabourMarket::Agreement < ApplicationRecord
  scope :lexicographical, -> { order(agreement_name: :asc) }
  scope :chronological, -> { order(created_at: :asc) }
  scope :reverse_chronological, -> { order(created_at: :desc) }
  has_many :documents, class_name: "LabourMarket::Document", dependent: :destroy, inverse_of: :agreement
  has_many :signatures, class_name: "LabourMarket::Signature", dependent: :destroy, inverse_of: :agreement
  has_many :members, through: :signatures, source: :organisation
  has_many :references, as: :referenceable
  has_many :translations, as: :translatable

  enum :agreement_visibility, [
    :agreement_hidden,
    :agreement_public,
  ]

  scope :description_missing, -> { where(agreement_description: [nil, ""]) }
  scope :description_present, -> { where.not(agreement_description: [nil, ""]) }

  scope :scope_missing, -> { where(agreement_scope: [nil, ""]) }
  scope :scope_present, -> { where.not(agreement_scope: [nil, ""]) }

  scope :documents_missing, -> {
    left_outer_joins(:documents)
      .where(labour_market_documents: { id: nil })
      .distinct
  }

  scope :documents_present, -> {
    left_outer_joins(:documents)
      .where.not(labour_market_documents: { id: nil })
      .distinct
  }

  scope :organisations_missing, -> {
    left_outer_joins(:signatures)
      .where(labour_market_signatures: { id: nil })
      .distinct
  }

  scope :organisations_present, -> {
    left_outer_joins(:signatures)
      .where.not(labour_market_signatures: { id: nil })
      .distinct
  }

  scope :references_missing, -> {
    left_outer_joins(:references)
      .where(labour_market_references: { id: nil })
  }

  scope :references_present, -> {
    left_outer_joins(:references)
      .where.not(labour_market_references: { id: nil })
      .distinct
  }

  scope :translations_missing, -> {
    left_outer_joins(:translations)
      .where(labour_market_translations: { id: nil })
  }

  scope :translations_present, -> {
    left_outer_joins(:translations)
      .where.not(labour_market_translations: { id: nil })
      .distinct
  }

  scope :agreement_complete, -> {
    description_present
      .scope_present
      .documents_present
      .organisations_present
      .references_present
      .translations_present
  }

  scope :agreement_incomplete, -> {
    base_query = left_outer_joins(:documents, :signatures, :references, :translations)
    base_query.where(agreement_description: [nil, ""])
      .or(base_query.where(agreement_scope: [nil, ""]))
      .or(base_query.where(labour_market_documents: { id: nil }))
      .or(base_query.where(labour_market_signatures: { id: nil }))
      .or(base_query.where(labour_market_references: { id: nil }))
      .or(base_query.where(labour_market_translations: { id: nil }))
      .distinct
  }

  before_create :set_slug
  def set_slug
    if self.agreement_slug.blank?
      self.agreement_slug = self.agreement_name.parameterize
    end
  end

  before_update :update_slug
  def update_slug
    if self.agreement_name_changed?
      self.agreement_slug = self.agreement_name.parameterize
    end
  end

  def agreement_complete?
    props = [
      :agreement_name,
      :agreement_description,
      :agreement_scope,
    ]
    return false if props.any? do |attribute|
      self.send(attribute).blank?
    end
    return false if self.documents.empty?
    return false if self.members.empty?
    return false if self.translations.empty?
    return true
  end

  rails_admin do
    object_label_method do
      :agreement_name
    end

    list do
      scopes [
        nil,
        :agreement_complete,
        :agreement_incomplete,
        :agreement_hidden,
        :agreement_public,
      ]
      field :agreement_complete?, :boolean do
        label "Ready?"
      end

      field :agreement_name
      field :agreement_slug
      field :created_at
      field :updated_at
      sort_by :created_at
    end

    create do
      field :agreement_name
      field :agreement_slug
      field :agreement_description
      field :agreement_scope
      field :agreement_visibility
      field :references
    end

    edit do
      field :agreement_name
      field :agreement_slug
      field :agreement_description
      field :agreement_scope
      field :agreement_visibility
      field :members
      field :references
      field :translations
    end

    show do
      field :agreement_name
      field :agreement_slug

      field :agreement_complete?, :boolean

      field :missing_fields do
        label "Missing Fields"
        pretty_value do
          bindings[:view].content_tag(:ul) {
            value.map do |field|
              bindings[:view].content_tag(:li, field)
            end.join.html_safe
          }.html_safe
        end

        visible do
          bindings[:object].agreement_complete? == false
        end
      end

      field :agreement_description
      field :agreement_scope
      field :agreement_visibility
      field :members
      field :documents

      configure :documents do
        pretty_value do
          bindings[:view].content_tag(:ul) {
            value.map do |field|
              bindings[:view].content_tag(:li) {
                "[#{
                  bindings[:view].content_tag(:a,
                    style: "font-family: monospace",
                    href: "/admin/labour_market~document/#{field.id}"
                  ) { field.id[0..7] }}]
                #{
                  bindings[:view].content_tag(:span) { field.document_name }
                }".html_safe
              }.html_safe
            end.join.html_safe
          }.html_safe
        end
      end

      field :references do
        pretty_value do
          bindings[:view].content_tag(:ul) {
            value.map do |field|
              bindings[:view].content_tag(:li) {
                "[#{
                  bindings[:view].content_tag(:a,
                    style: "font-family: monospace",
                    href: "/admin/labour_market~reference/#{field.id}"
                  ) { field.id[0..4] }}]
                #{
                  bindings[:view].content_tag(:a,
                    # style: "font-family: monospace",
                    href: field.url
                  ) { field.url }
                }".html_safe
              }.html_safe
            end.join.html_safe
          }.html_safe
        end
      end

      field :translations

      field :translations do
        pretty_value do
          bindings[:view].content_tag(:ul) {
            value.map do |field|
              bindings[:view].content_tag(:li) {
                "[#{
                  bindings[:view].content_tag(:a,
                    style: "font-family: monospace",
                    href: "/admin/labour_market~translation/#{field.id}"
                  ) { field.translation_type }}]
                #{
                  bindings[:view].content_tag(:span) { field.translation_text }
                }".html_safe
              }.html_safe
            end.join.html_safe
          }.html_safe
        end
      end
    end
  end

  def missing_fields
    fields = []
    fields << "Name" if self.agreement_name.blank?
    fields << "Description" if self.agreement_description.blank?
    fields << "Scope" if self.agreement_scope.blank?
    fields << "Documents" if self.documents.empty?
    fields << "Organisations" if self.members.empty?
    fields << "Translations" if self.translations.empty?
    fields << "References" if self.references.empty?
    fields
  end

  def to_param
    agreement_slug
  end
end
