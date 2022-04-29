<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="77afb225-0180-1000-802e-7f0000012739" type="" style="Table" enable="true">
	<name><![CDATA[treatment and patient]]></name>
	<description><![CDATA[This report is used to provide the stake holders  with the total number of patients diagnosed with a certain disease. This data will be a decision making constraint in improving the infrastraucture of the department involved in treating the higher volume disease and improve the efficiency of the hospital with higher customer service level.]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select ph.treatment, count(pd.patient_id) as no_of_patients from PATIENT_DOCUMENT pd 
join PATIENT_HISTORY ph on pd.file_id = ph.file_id group by ph.treatment order by ph.treatment]]></sql>
	</query>
</display>
</displays>