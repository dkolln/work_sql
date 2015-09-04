begin tran
--commit
--rollback

update core.campaign_contact
set contact_cost = v.contact_cost
--select count(*)
from core.campaign_contact c
	inner join utility.dbo.x_dlk_matches v on
		v.campaign_wk = c.campaign_wk

--update 1,392,633 rows of data.
