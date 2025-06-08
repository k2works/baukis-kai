class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
      unless value.present? && value.count('@') == 1 && value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add(attribute, :invalid)
    end

    if value.present? && value.count('@') != 1
      record.errors.add(attribute, :invalid)
    end
  end
end
