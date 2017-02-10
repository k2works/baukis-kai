class Admin::AllowedSourcesDeleter
  def delete(params)
    ids = []
    params.each do |hash|
      if hash[:_destroy] == '1'
        ids << hash[:id]
      end
    end
    if ids.present?
      AllowedSource.where(namespace: 'staff', id: ids).delete_all
    end
  end
end