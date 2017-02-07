class Staff::CustomerSearchForm
  include ActiveModel::Model

  attr_accessor :family_name_kana,
                :given_name_kana,
                :birth_year,
                :birth_month,
                :birth_mday,
                :address_type,
                :prefecture,
                :city,
                :phone_number

  def search
    rel = Customer
    if family_name_kana.present?
      rel = rel.where(family_name_kana: family_name_kana)
    end
    if given_name_kana.present?
      rel = rel.where(given_name_kana: given_name_kana)
    end
    rel = rel.where(birth_year: birth_year) if birth_year.present?
    rel = rel.where(birth_month: birth_month) if birth_month.present?
    rel = rel.where(birth_mday: birth_mday) if birth_mday.present?

    rel.order(:family_name_kana, :given_name_kana)
  end
end