class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :product_ids, :auth_token

  def product_ids
    object.products.map {|product| {id: product.id}}
  end

end
