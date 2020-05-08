INSERT INTO md.target_types (name)
SELECT 'Price'
UNION
SELECT 'Product name'
UNION
SELECT 'UPC';

INSERT INTO md.actions (name)
SELECT 'email'
UNION
SELECT 'http_post';

INSERT INTO md.action_triggers (name)
SELECT 'change'
UNION
SELECT 'increase'
UNION
SELECT 'decrease';

INSERT INTO md.action_thresholds (type)
SELECT 'absolute'
UNION
SELECT 'percent';

-- test data
INSERT INTO md.users (user_info)
SELECT '[]'::jsonb;
