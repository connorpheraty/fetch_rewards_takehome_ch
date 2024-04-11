## Relational Modeling

### Table: brands

| Column Name   | Data Type | PK (Primary Key) | FK (Foreign Key) | Description                                           |
|---------------|-----------|------------------|------------------|-------------------------------------------------------|
| brand_id      | STRING    | PK               |                  | Unique identifier for the brand (from JSON `_id.$oid`)|
| barcode       | STRING    |                  |                  | Barcode associated with the brand                     |
| category      | STRING    |                  |                  | Category of the brand                                 |
| category_code | STRING    |                  |                  | Code representing the category of the brand           |
| cpg_id        | STRING    |                  | FK               | Identifier of the CPG (from JSON `cpg.$id.$oid`)      |
| cpg_ref       | STRING    |                  |                  | Reference name of the CPG (from JSON `cpg.$ref`)      |
| name          | STRING    |                  |                  | Name of the brand                                     |
| brand_code    | STRING    |                  |                  | Code associated with the brand                        |


### Table: users

| Column Name   | Data Type     | PK (Primary Key) | FK (Foreign Key) | Description                                                      |
|---------------|---------------|------------------|------------------|------------------------------------------------------------------|
| user_id       | STRING        | PK               |                  | Unique identifier for the user (from JSON `raw_json:_id:"$oid"`) |
| state         | STRING        |                  |                  | State attribute from user data                                   |
| created_date  | TIMESTAMP_NTZ |                  |                  | Account creation date (from JSON `raw_json:createdDate:"$date"`) |
| last_login    | TIMESTAMP_NTZ |                  |                  | Date of the last login (from JSON `raw_json:lastLogin:"$date"`)  |
| role          | STRING        |                  |                  | Role assigned to the user                                        |
| is_active     | BOOLEAN       |                  |                  | Boolean flag indicating if the user account is active            |

### Table: receipts


| Column Name                | Data Type     | PK (Primary Key) | FK (Foreign Key)         | Description                                              |
|----------------------------|---------------|------------------|--------------------------|----------------------------------------------------------|
| receipt_id                 | STRING        | PK               |                          | Unique identifier for the receipt (from JSON `_id.$oid`) |
| user_id                    | STRING        |                  | FK to users table        | Identifier of the user associated with the receipt       |
| rewards_receipt_status     | STRING        |                  |                          | Status of the receipt regarding rewards                  |
| create_date                | TIMESTAMP     |                  |                          | Date when the receipt was created                        |
| date_scanned               | TIMESTAMP     |                  |                          | Date when the receipt was scanned                        |
| purchase_date              | TIMESTAMP     |                  |                          | Date when the purchase related to the receipt took place |
| finished_date              | TIMESTAMP     |                  |                          | Date when the receipt processing was finished            |
| modify_date                | TIMESTAMP     |                  |                          | Date when the receipt was last modified                  |
| points_awarded_date        | TIMESTAMP     |                  |                          | Date when the points for the receipt were awarded        |
| purchased_item_count       | INT           |                  |                          | Number of items purchased as recorded on the receipt     |
| total_spent                | DECIMAL(10,2) |                  |                          | Total amount spent as recorded on the receipt            |
| points_earned              | FLOAT         |                  |                          | Points earned from the receipt                           |
| bonus_points_earned        | INT           |                  |                          | Bonus points earned from the receipt                     |
| bonus_points_earned_reason | STRING        |                  |                          | Reason for the bonus points being earned                 |
| rewards_receipt_item_list  | VARIANT       |                  |                          | List of items on the receipt (stored as JSON)            |


### Table: receipt_items


| Column Name                           | Data Type | PK (Primary Key) | FK (Foreign Key) | Description                                                |
|---------------------------------------|-----------|------------------|------------------|------------------------------------------------------------|
| receipt_item_id                       | STRING    | PK               |                  | Composite key made up of receipt_id and partnerItemId      |
| receipt_id                            | STRING    |                  | FK               | Foreign key to the receipt                                 |
| user_id                               | STRING    |                  | FK               | Foreign key to the user                                    |
| rewards_receipt_status                | STRING    |                  |                  | Status of the receipt                                     |
| partner_item_id                       | STRING    |                  |                  | Partner item identifier                                   |
| barcode                               | STRING    |                  |                  | Barcode number of the item                                |
| brand_code                            | STRING    |                  |                  | Brand code for the item                                   |
| description                           | STRING    |                  |                  | Description of the item                                   |
| number                                | STRING    |                  |                  | Item number                                               |
| original_final_price                  | STRING    |                  |                  | Original final price of the item                          |
| final_price                           | STRING    |                  |                  | Final price after discounts of the item                   |
| price                                 | STRING    |                  |                  | Original price of the item                                |
| discounted_price                      | STRING    |                  |                  | Discounted price of the item                              |
| price_after_coupon                    | STRING    |                  |                  | Price of the item after coupon is applied                 |
| target_price                          | STRING    |                  |                  | Target price of the item                                  |
| quantity_purchased                    | INTEGER   |                  |                  | Quantity of the item purchased                            |
| user_flagged_quantity                 | INTEGER   |                  |                  | Quantity flagged by the user                              |
| original_metabrite_quantity_purchased | INTEGER   |                  |                  | Quantity originally captured by MetaBrite                 |
| original_text                         | STRING    |                  |                  | Original text from the receipt for the item               |
| original_metabrite_barcode            | STRING    |                  |                  | Original MetaBrite barcode                                |
| original_metabrite_description        | STRING    |                  |                  | Original MetaBrite description                            |
| original_metabrite_item_price         | STRING    |                  |                  | Original MetaBrite item price                             |
| user_flagged_barcode                  | STRING    |                  |                  | Barcode flagged by the user                               |
| user_flagged_price                    | STRING    |                  |                  | Price flagged by the user                                 |
| user_flagged_description              | STRING    |                  |                  | Description flagged by the user                           |
| user_flagged_new_item                 | BOOLEAN   |                  |                  | Indicates whether the user flagged the item as new        |
| points_earned                         | INTEGER   |                  |                  | Points earned from the item purchase                      |
| points_not_awarded_reason             | STRING    |                  |                  | Reason for not awarding points                            |
| points_payer_id                       | STRING    |                  |                  | Identifies the payer of the points                        |
| rewards_product_partner_id            | STRING    |                  |                  | Partner ID associated with the product for rewards        |
| metabrite_campaign_id                 | STRING    |                  |                  | MetaBrite campaign identifier                             |
| rewards_group                         | STRING    |                  |                  | Rewards group classification                             |
| competitor_rewards_group              | STRING    |                  |                  | Competitor's rewards group classification                 |
| competitive_product                   | BOOLEAN   |                  |                  | Indicates whether the product is considered competitive   |
| needs_fetch_review                    | BOOLEAN   |                  |                  | Flag indicating if the item needs a fetch review          |
| needs_fetch_review_reason             | STRING    |                  |                  | Reason why the item needs a fetch review                  |
| prevent_target_gap_points             | BOOLEAN   |                  |                  | Flag indicating prevention of gap points for target       |
| deleted                               | BOOLEAN   |                  |                  | Flag indicating if the item is marked as deleted          |
