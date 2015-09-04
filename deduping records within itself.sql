/* 1.  Query heading */
SELECT
  *  /* Remember to never use SELECT * and write out the field names */
FROM
  /* 2.  Table with duplicates */
  SHIPMENT_ORDERS
WHERE
  EXISTS  (
    SELECT
      NULL
    FROM
      /* 3.  Table with duplicates, with an alias */
      SHIPMENT_ORDERS b
    WHERE
      /* 4.  Join each field with *itself*.  These are fields that could be Primary Keys */
      b.[shipment] = SHIPMENT_ORDERS.[shipment]
      AND b.[purchase_order] = SHIPMENT_ORDERS.[purchase_order]
      AND b.[item_sku] = SHIPMENT_ORDERS.[item_sku]
    GROUP BY
            /* 5.  I must GROUP BY these fields because of the HAVING
         clause and because these are the possible PK */
      b.[shipment], b.[purchase_order], b.[item_sku]
    HAVING
      /* 6.  This is the determining factor.  We can control our
         output from here.  In this case, we want to pick records
         where the ID is less than the MAX ID */
      SHIPMENT_ORDERS.[id] < MAX(b.[id])
  )
