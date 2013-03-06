puts "Creating ISO 9001 Quality Management System Requirements..."
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => '9001:2008 sets out the criteria for a quality management system',
                               :regulatory_review_name => 'ISO 9001:2008 - Continual Improvement Checklist',
                               :frequency => 'Annual',                            
                               :objectives => "The organization must have in place suitable methods for supporting continual improvement of its QMS.  Describe the organization's QMS improvement methods. Note any exceptions to the organization's QMS policy and report to the appropriate person for corrective action.  When you identify a means to improve a method, document your findings and forward to the appropriate person."
                               })
                      
tasks = []

tasks << {
:name => "General Requirements - Measurement, Analysis and Improvement",
:instructions => <<EOT
1. Describe the processes within your organization to continually improve the effectiveness of its QMS. 
2. Identify evidence of improvement.  If there is no evidence of improvement, explain why.
3. Describe the statistical tools used within the organization to analyze data.
4. Provide evidence that these statistical tools are being used appropriately.
EOT
}

tasks << {
:name => "Customer Satisfaction",
:instructions => <<EOT
1. Describe how your organization measures and monitors its customers' perception of whether the organization has met their requirements.
2. Identify evidence that customer satisfaction data is being collected properly.  If there is no evidence of customer satisfaction monitoring, explain why.
3. Identify the individual who evaluates customer satisfaction data and whether or not action is required.  Verify that the responsibility to initiate corrective or preventive action is clearly defined and understood.
4. List actions that have been taken as a result of customer satisfaction data.  Review records describing what actions were taken and verify that the actions taken were appropriate.
EOT
}

tasks << {
:name => "Internal Audits",
:instructions => <<EOT
1. Describe the QMS internal audit process at your organization. Include in this description:
  a. How internal QMS audits are planned and conducted;
  b. How they are documented;
  c. How any required corrections and corrective actions are documented and monitored.
2. Obtain the internal audit schedule for the previous year.  Confirm that audits were scheduled based on the status and importance of the process and based on previous audit results.
3. Select a sampling of audit reports at random from the previous year and verify that they were conducted in accordance with the QMS internal audit schedule.  Use these audit reports for the remainder of the items in this Task.
4. Describe how auditors are qualified.  Include in the workspace below training records for the auditors who performed the above audits to verify that that they were qualified for the procedure.  If they were not qualified, note this issue and report it to the appropriate person.
5. Confirm with auditors, or verify by other means, that they did not audit their own work.
6. Verify that auditors documented evidence of both conformance and non-conformance.
7. Explain how audit results are presented to the individual(s) who are responsible for the process that was audited.
8. Review and describe how internal audit findings of nonconformance were corrected in a timely manner.  
  a. Was the cause of the problem identified?
  b. Was action taken to eliminate the cause?
  c. Was the action taken effective?
  d. Were associated documents updated and a result of the action?
  e. Was the action promptly completed?
9. List specific improvements to the business that resulted from the internal audit process.
  a. Is there anything, in your opinion, that could be done to improve the effectiveness of the internal audits that would result in improvements to the business?
EOT
}

template.tasks = tasks.to_json
template.save!

