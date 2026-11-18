-- Heine Brothers’ Coffee | Three Sample SQL Queries
-- Academic case study: all transactional and operating data is synthetic.
-- Database: heine_coffee_demo.sqlite (SQLite)

-- QUERY 1: Store revenue and completed-order volume (October 2026)
-- Skills: INNER JOIN, SUM, COUNT DISTINCT, GROUP BY, ORDER BY
SELECT
    s.StoreName,
    COUNT(DISTINCT o.OrderID) AS CompletedOrders,
    ROUND(SUM(ol.Quantity * ol.UnitPriceAtSale - ol.DiscountAmount), 2) AS NetRevenue
FROM SalesOrder AS o
JOIN Store AS s ON o.StoreID = s.StoreID
JOIN OrderLine AS ol ON ol.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'
  AND o.OrderDateTime >= '2026-10-01'
  AND o.OrderDateTime < '2026-11-01'
GROUP BY s.StoreID, s.StoreName
ORDER BY NetRevenue DESC;

-- QUERY 2: Fern Creek's top five beverages in October 2026
-- Skills: multi-table JOIN, subtype filtering, aggregation, LIMIT
SELECT
    mi.ItemName,
    SUM(ol.Quantity) AS UnitsSold,
    ROUND(SUM(ol.Quantity * ol.UnitPriceAtSale - ol.DiscountAmount), 2) AS NetRevenue
FROM SalesOrder AS o
JOIN Store AS s ON s.StoreID = o.StoreID
JOIN OrderLine AS ol ON ol.OrderID = o.OrderID
JOIN MenuItem AS mi ON mi.ItemID = ol.ItemID
JOIN Beverage AS b ON b.ItemID = mi.ItemID
WHERE s.StoreName = 'Fern Creek'
  AND o.OrderStatus = 'Completed'
  AND o.OrderDateTime >= '2026-10-01'
  AND o.OrderDateTime < '2026-11-01'
GROUP BY mi.ItemID, mi.ItemName
ORDER BY NetRevenue DESC, mi.ItemName
LIMIT 5;

-- QUERY 3: Reorder-needed stock with preferred supplier (October snapshot)
-- Skills: multi-table JOIN, LEFT JOIN, calculated field, filtering
SELECT
    s.StoreName,
    i.IngredientName,
    ROUND(si.QtyOnHand, 1) AS QtyOnHand,
    ROUND(si.ReorderPoint, 1) AS ReorderPoint,
    ROUND(si.ReorderPoint - si.QtyOnHand, 1) AS Shortfall,
    COALESCE(sup.SupplierName, 'No preferred supplier') AS PreferredSupplier
FROM StoreInventory AS si
JOIN Store AS s ON s.StoreID = si.StoreID
JOIN Ingredient AS i ON i.IngredientID = si.IngredientID
LEFT JOIN SupplierIngredient AS link
    ON link.IngredientID = i.IngredientID AND link.PreferredSupplier = 1
LEFT JOIN Supplier AS sup ON sup.SupplierID = link.SupplierID
WHERE si.QtyOnHand < si.ReorderPoint
ORDER BY Shortfall DESC, s.StoreName, i.IngredientName
LIMIT 15;
