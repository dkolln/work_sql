use rrs_campaignmanager
select name from syscolumns where id=object_id('an.hist_srp_letters_usrp')

SELECT * FROM dbo.sysobjects WHERE xtype = 'U' 

select o.name
from syscolumns s
	inner join dbo.sysobjects o on
		o.id = s.id
where
	s.name like '%disposer%'

select *
from campaign_cfg_usrp_disposer
