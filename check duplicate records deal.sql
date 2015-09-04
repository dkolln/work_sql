-- Analysis for TP 10754

-- are there duplicate fc_deal records for 10012539 or 10004681?

--select * from subscriber.organization where org_nk in ('10012539', '10004681')
--
--6826
--23623

declare @org_wk int;
set @org_wk = 6826;

with cte_dups as
(
       select
              vin,
              address_1,
              deal_date,
              count(*) as count_deals
       from
              dbo.fc_deal
       where
              org_wk = @org_wk
       group by
              vin,
              address_1,
              deal_date
       having
              count(*)>1
),
cte_jobs as
(
       select
              fd.deal_wk,
              fd.vin,
              fd.deal_date,
              fd.job_wk,
              fd.deal_number,
              row_number()over(partition by fd.vin, fd.deal_date order by job_wk desc) as rownum
       from
              dbo.fc_deal fd
              inner join cte_dups cd on
                     fd.vin = cd.vin and
                     fd.address_1 = cd.address_1 and
                     fd.deal_date = cd.deal_date
       where
              fd.org_wk = @org_wk 
)
select
       ctj.deal_wk,
       ctj.vin,
       ctj.deal_number,
       ctj.deal_date,
       ctj.job_wk,
       job_defn_name,
       cj.start_dt,
       ctj.rownum
from
       cte_jobs ctj
       inner join svrrrdb10.rrs_jobmanager.dbo.ctl_job cj
              on ctj.job_wk = cj.job_wk
       inner join svrrrdb10.rrs_jobmanager.dbo.ctl_job_defn cjd on
              cj.job_defn_wk = cjd.job_defn_wk
order by
       ctj.vin,
       ctj.deal_date,
       rownum
