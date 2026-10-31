import 'package:dummy/domain/entities/auth_entity.dart';
import 'package:dummy/domain/entities/product_entity.dart';

/// Trimmed copy of a real `GET /products/1` response.
const productJson = <String, dynamic>{
  'id': 1,
  'title': 'Essence Mascara Lash Princess',
  'description': 'A popular mascara known for its volumizing effects.',
  'category': 'beauty',
  'price': 9.99,
  'discountPercentage': 10.48,
  'rating': 2.56,
  'stock': 99,
  'tags': ['beauty', 'mascara'],
  'brand': 'Essence',
  'sku': 'BEA-ESS-ESS-001',
  'weight': 4,
  'dimensions': {'width': 15.14, 'height': 13.08, 'depth': 22.99},
  'warrantyInformation': '1 week warranty',
  'shippingInformation': 'Ships in 3-5 business days',
  'availabilityStatus': 'In Stock',
  'reviews': [
    {
      'rating': 3,
      'comment': 'Would not recommend!',
      'date': '2025-04-30T09:41:02.053Z',
      'reviewerName': 'Eleanor Collins',
      'reviewerEmail': 'eleanor.collins@x.dummyjson.com',
    },
  ],
  'returnPolicy': 'No return policy',
  'images': [
    'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp',
  ],
  'thumbnail':
      'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp',
};

const loginResponseJson = <String, dynamic>{
  'id': 1,
  'username': 'emilys',
  'email': 'emily.johnson@x.dummyjson.com',
  'firstName': 'Emily',
  'lastName': 'Johnson',
  'gender': 'female',
  'image': 'https://dummyjson.com/icon/emilys/128',
  'accessToken': 'access-token',
  'refreshToken': 'refresh-token',
};

const testUser = UserEntity(
  id: 1,
  username: 'emilys',
  email: 'emily.johnson@x.dummyjson.com',
  firstName: 'Emily',
  lastName: 'Johnson',
  image: '',
);

ProductEntity buildProduct(int id) => ProductEntity(
  id: id,
  title: 'Product $id',
  description: 'Description $id',
  category: 'beauty',
  price: 10.0 + id,
  discountPercentage: 5,
  rating: 4.2,
  stock: 10,
  // Empty so widget tests don't hit the network.
  thumbnail: '',
);

/// A page of products with consecutive ids starting after [skip].
ProductPageEntity buildPage({
  required int skip,
  int count = 20,
  int total = 194,
}) => ProductPageEntity(
  products: [for (var i = 1; i <= count; i++) buildProduct(skip + i)],
  total: total,
  skip: skip,
);
