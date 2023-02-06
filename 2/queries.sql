ALTER TABLE `groups` ADD COLUMN column_1 VARCHAR(200);
ALTER TABLE `groups` ADD COLUMN column_2 INT NOT NULL;
ALTER TABLE `groups` ADD COLUMN column_3 DATE;

ALTER TABLE `groups` RENAME COLUMN id TO group_id;

CREATE INDEX group_name_idx ON `groups`(name);
CREATE INDEX users_idx ON users(group_id, name);