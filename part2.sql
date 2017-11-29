-- User finds what they are looking for faster
-- User finds what they are looking more realiably
-- User isn't giving up in the search flow
-- User spends less effort in searching

SELECT e.event_name,
  COUNT(e.event_name)
  FROM tutorial.yammer_events e
  WHERE e.event_name = 'search_autocomplete' OR e.event_name = 'search_run' OR e.event_name LIKE 'search_click_result_%'
  GROUP BY 1
  ORDER BY 2 DESC
  
SELECT COUNT(1)
  FROM tutorial.yammer_events e
  WHERE e.event_name LIKE 'search_click_result_%'
  
-- There are room for improvement, for example only 9772 times the search results are actually clicked on compared to 17280 times auto complete occurs and 13019 times search run occurs.
-- The quality of results can be improved, it should skrew to first few results more so than right now