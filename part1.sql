-- Hypothesis:
-- 1. Location specific
-- 2. Device specific
-- 3. Broken feature got out

SELECT 
    DATE_TRUNC('week', e.occurred_at),
    e.location,
    COUNT(DISTINCT e.user_id) AS weekly_active_users
  FROM tutorial.yammer_events e
 WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
   AND e.occurred_at > '2014-07-01T00:00:00.000Z'
 GROUP BY 1, 2
 ORDER BY 1
 
 -- Did not see any location that breaks from the general trend
 
 SELECT 
    DATE_TRUNC('week', e.occurred_at),
    e.device,
    COUNT(DISTINCT e.user_id) AS weekly_active_users
  FROM tutorial.yammer_events e
 WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
   AND e.occurred_at > '2014-07-01T00:00:00.000Z'
 GROUP BY 1, 2
 ORDER BY 1
 
 SELECT 
    DISTINCT e.device
  FROM tutorial.yammer_events e
 
 -- Noticed that some device drops more significantly than others
 -- Went down the list of queries each device
 
 SELECT 
    DATE_TRUNC('week', e.occurred_at),
    e.device,
    COUNT(DISTINCT e.user_id) AS weekly_active_users
  FROM tutorial.yammer_events e
 WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
   AND e.occurred_at > '2014-07-01T00:00:00.000Z'
   AND e.device = 'kindle fire'
 GROUP BY 1, 2
 ORDER BY 1
 
 -- Noticed that mobile devices has a steep drop but not other devices. 
 -- Also both Android and iOS devices are dropping at similar rate, this appears to be an issue for all mobile devices but not platform specific.
 
 
-- Try joining event table with other table and see what we get
SELECT 
    DATE_TRUNC('week', e.occurred_at),
    e.device,
    emails.action,
    COUNT(DISTINCT e.user_id) AS weekly_active_users
  FROM tutorial.yammer_events e
  JOIN tutorial.yammer_emails emails
    ON e.user_id = emails.user_id
 WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
   AND e.occurred_at > '2014-07-01T00:00:00.000Z'
 GROUP BY 1, 2, 3
 ORDER BY 1
 
 -- See drops from email_clickthrogh, email_open, and sent_weekly_digest but sent_reenagement_email remains fine
 -- reduced sent should affect email_open, so look into that
 
SELECT 
    DATE_TRUNC('week', e.occurred_at),
    e.device,
    COUNT(emails.action) AS weekly_action
  FROM tutorial.yammer_events e
  JOIN tutorial.yammer_emails emails
    ON e.user_id = emails.user_id
 WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
   AND e.occurred_at > '2014-07-01T00:00:00.000Z'
   AND emails.action = 'sent_weekly_digest'
 GROUP BY 1, 2
 ORDER BY 1
 
 -- Couldn't draw anything meaning full here from looking at individual device
 -- Recommendation is to look into into why mobile usage dropped, and why email_clickthrogh, email_open, and sent_weekly_digest actions dropped