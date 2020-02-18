--597. Friend Requests I: Overall Acceptance Rate
-- (Easy) Friend Requests I: Overall Acceptance Rate
-- friend_request
-- | sender_id | send_to_id |request_date|
-- |-----------|------------|------------|
-- | 1         | 2          | 2016_06-01 |
-- | 1         | 3          | 2016_06-01 |
-- | 1         | 4          | 2016_06-01 |
-- | 2         | 3          | 2016_06-02 |
-- | 3         | 4          | 2016-06-09 |
--
-- request_accepted
-- | requester_id | accepter_id |accept_date |
-- |--------------|-------------|------------|
-- | 1            | 2           | 2016_06-03 |
-- | 1            | 3           | 2016-06-08 |
-- | 2            | 3           | 2016-06-08 |
-- | 3            | 4           | 2016-06-09 |
-- | 3            | 4           | 2016-06-10 |
-- ​
-- |accept_rate|
-- |-----------|
-- |       0.80|

-- The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
-- It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
-- If there is no requests at all, you should return 0.00 as the accept_rate.

--The divisor (total number of requests) could be '0'
--if the table friend_request is empty.
--So, we have to utilize ifnull to deal with this special case.

SELECT
ROUND(
    IFNULL(
        (SELECT COUNT(distinct requester_id, accepter_id)
         FROM request_accepted)/
        (SELECT COUNT(distinct sender_id, send_to_id)
         FROM friend_request)
    ,0)
,2) accept_rate
