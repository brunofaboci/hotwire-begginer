class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to 'quotes', partial: 'quotes/quote', locals: { quote: self }, target: 'quotes' }

  # por padrao, a opcao "target" é igual a "model_name.plural", que, nesse caso, é igual a "quotes",
  # então podemos remover o parametro "target"

  # o valor padrão da opção "partial" é o mesmo que chamar "to_partial_path em uma instanca do model,"
  # que nesse caso é igual a "quotes/quote, então também podemos remove-lo"

  # a opção "locals" recebe por padrão um valor igual a "{ model_name.element.to_sym => self }",
  # que no contexto do model Quote é igual a { quote: self }, então também podemos remove-lo

  # after_create_commit -> { broadcast_prepend_later_to 'quotes' }
  # after_update_commit -> { broadcast_replace_later_to 'quotes' }
  # after_destroy_commit -> { broadcast_remove_to 'quotes' }
  broadcasts_to ->(quote) { 'quotes' }, inserts_by: :prepend
end
