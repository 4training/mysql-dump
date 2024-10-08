USE 4training;
DELETE FROM mw_user_former_groups;
DELETE FROM mw_querycachetwo;
DELETE FROM mw_user_properties;
DELETE FROM mw_watchlist;
DELETE FROM mw_uploadstash;

DELETE FROM mw_filearchive;
DELETE FROM mw_archive;

-- This is a sensitive table... things break when deleting from it
-- Also actor_name must be the same to user_name in mw_user, otherwise logging in fails
UPDATE mw_actor SET actor_name=(CAST(CONCAT('user', actor_id) AS BINARY)) WHERE actor_user!=1 OR actor_user IS NULL;

-- Clear out these comments - there are user names and maybe other sensitive data in there
UPDATE mw_comment SET comment_hash=0, comment_text='';

-- There was one entry for a try with OAuth for AvailableResourcesBot, better delete it
DELETE FROM mw_oauth_registered_consumer;

-- We want to keep only the admin user
DELETE FROM mw_user WHERE user_id > 1;
-- Set password to '4training'
UPDATE mw_user SET user_password=_binary ':pbkdf2:sha512:30000:64:pjtCXscgI3Z0OZDuZv8m9w==:l/Je0AYVy0okCapxuIkAfAxYmgnWu4PmtgJxY2J+3PmYqu77BGVSPA5zBZUwCky/3oV/dqGkhy9sXGXWmUww1w==' WHERE user_id=1;
UPDATE mw_user SET user_email=_binary 'admin@localhost';
UPDATE mw_user SET user_newpassword='';
UPDATE mw_user SET user_newpass_time=NULL;
-- Rename user to 'Admin'
UPDATE mw_user SET user_name=_binary 'Admin' WHERE user_id=1;
UPDATE mw_actor SET actor_name=_binary 'Admin' WHERE actor_user=1;

-- Empty the logs
DELETE FROM mw_updatelog;
DELETE FROM mw_logging;
DELETE FROM mw_log_search;

-- Empty the main cache tables
DELETE FROM mw_module_deps;
DELETE FROM mw_l10n_cache;
DELETE FROM mw_objectcache;

