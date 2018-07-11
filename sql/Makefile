backup:
	mysqldump -u root -p webwarecl > webwarecl.sql
	mysqldump -u root -p webware_cms > webware_cms.sql
	mysqldump -u root -p sites > sites.sql

restore:
	mysql -u root -p < webwarecl.sql
	mysql -u root -p < webware_cms.sql
	mysql -u root -p < sites.sql

