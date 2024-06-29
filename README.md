## Knicko CoinGate Proxy API

### Endpoints

#### Create Order
- **URL:** `/orders`
- **Method:** `POST`
- **Headers:** `Authorization: Bearer <token>`
- **Body:**
  ```json
  {
    "order": {
      "price_amount": "100.0",
      "price_currency": "USD",
      "receive_currency": "BTC",
      "callback_url": "https://example.com/callback",
      "cancel_url": "https://example.com/cancel",
      "success_url": "https://example.com/success",
      "title": "Order title",
      "description": "Order description"
    }
  }
  ```

#### Retrieve Order
- **URL:** `/orders/:id`
- **Method:** `GET`
- **Headers:** `Authorization: Bearer <token>`

#### Cancel Order
- **URL:** `/orders/:id`
- **Method:** `DELETE`
- **Headers:** `Authorization: Bearer <token>`

### Authentication
Use Devise to authenticate users.