CREATE TABLE `rakamin-kf-analytics-485414.kimia_farma.business_sales_data` AS 
SELECT
    tfx.transaction_id,
    tfx.date,
    tfx.branch_id,
    kcb.branch_name,
    kcb.kota,
    kcb.provinsi,
    kcb.rating AS rating_cabang,
    tfx.customer_name,
    tfx.product_id,
    prd.product_name,
    prd.price AS actual_price,
    tfx.discount_percentage,
    CASE
        WHEN tfx.price <= 50000 THEN 0.10
        WHEN tfx.price > 50000 AND tfx.price <= 100000 THEN 0.15
        WHEN tfx.price > 100000 AND tfx.price <= 300000 THEN 0.20
        WHEN tfx.price > 300000 AND tfx.price <= 500000 THEN 0.25
        WHEN tfx.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    (tfx.price * (1 - (tfx.discount_percentage / 100)))AS nett_sales,
    tfx.price * (
        CASE
            WHEN tfx.price <= 50000 THEN 0.10
            WHEN tfx.price > 50000 AND tfx.price <= 100000 THEN 0.15
            WHEN tfx.price > 100000 AND tfx.price <= 300000 THEN 0.20
            WHEN tfx.price > 300000 AND tfx.price <= 500000 THEN 0.25
            WHEN tfx.price > 500000 THEN 0.30
        END
    ) AS nett_profit,
    tfx.rating AS rating_transaksi
FROM
    `rakamin-kf-analytics-485414.kimia_farma.kf_final_transaction` tfx
LEFT JOIN
    `rakamin-kf-analytics-485414.kimia_farma.kf_kantor_cabang` kcb ON tfx.branch_id = kcb.branch_id
LEFT JOIN
    `rakamin-kf-analytics-485414.kimia_farma.kf_product` prd ON tfx.product_id = prd.product_id;
