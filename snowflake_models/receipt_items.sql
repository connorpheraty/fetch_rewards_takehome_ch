SELECT 
    -- Receipt and User Identifiers
    r.receipt_id,
    r.user_id,

    -- Receipt Status
    r.rewards_receipt_status,

    -- Item Identifiers and Descriptions
    i.value:partnerItemId::STRING AS partner_item_id,
    i.value:barcode::STRING AS barcode,
    i.value:brandCode::STRING AS brand_code,
    i.value:description::STRING AS description,
    i.value:itemNumber::STRING AS number,

    -- Pricing Details
    i.value:originalFinalPrice::STRING AS original_final_price,
    i.value:finalPrice::STRING AS final_price,
    i.value:itemPrice::STRING AS price,
    i.value:discountedItemPrice::STRING AS discounted_price,
    i.value:priceAfterCoupon::STRING AS price_after_coupon,
    i.value:targetPrice::STRING AS target_price,

    -- Quantities
    i.value:quantityPurchased::INTEGER AS quantity_purchased,
    i.value:userFlaggedQuantity::INTEGER AS user_flagged_quantity,
    i.value:originalMetaBriteQuantityPurchased::INTEGER AS original_metabrite_quantity_purchased,

    -- Original Receipt Text and Values (for reference)
    i.value:originalReceiptItemText::STRING AS original_text,
    i.value:originalMetaBriteBarcode::STRING AS original_metabrite_barcode,
    i.value:originalMetaBriteDescription::STRING AS original_metabrite_description,
    i.value:originalMetaBriteItemPrice::STRING AS original_metabrite_item_price,

    -- User-Flagged Values
    i.value:userFlaggedBarcode::STRING AS user_flagged_barcode,
    i.value:userFlaggedPrice::STRING AS user_flagged_price,
    i.value:userFlaggedDescription::STRING AS user_flagged_description,
    i.value:userFlaggedNewItem::BOOLEAN AS user_flagged_new_item,

    -- Points and Rewards
    i.value:pointsEarned::INTEGER AS points_earned,
    i.value:pointsNotAwardedReason::STRING AS points_not_awarded_reason,
    i.value:pointsPayerId::STRING AS points_payer_id,
    i.value:rewardsProductPartnerId::STRING AS rewards_product_partner_id,
    i.value:metabriteCampaignId::STRING AS metabrite_campaign_id,
    i.value:rewardsGroup::STRING AS rewards_group,
    i.value:competitorRewardsGroup::STRING AS competitor_rewards_group,
    i.value:competitiveProduct::BOOLEAN AS competitive_product,

    -- Review and Compliance Requirement Flags
    i.value:needsFetchReview::BOOLEAN AS needs_fetch_review,
    i.value:needsFetchReviewReason::STRING AS needs_fetch_review_reason,
    i.value:preventTargetGapPoints::BOOLEAN AS prevent_target_gap_points,

    -- Status Flags
    i.value:deleted::BOOLEAN AS deleted,

    -- Raw Receipt Data (JSON)
    r.raw_json

FROM fetch_ch_takehome.reporting.receipts AS r,
LATERAL FLATTEN(input => r.rewards_receipt_item_list) AS i
;