class Like < Socialization::ActiveRecordStores::Like

  def self.like_ids
    all.map(&:likeable_id)
  end

  def self.products
    Product.where(id: like_ids)
  end

end
