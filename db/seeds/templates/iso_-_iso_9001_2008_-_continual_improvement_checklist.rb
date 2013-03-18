# encoding: UTF-8
puts "Creating ISO 9001:2008 - Continual Improvement Checklist ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('ISO'),
                               :full_name => 'ISO 9001:2008 Quality Management System Requirements',
                               :display_name => 'ISO 9001',
                               :description => '9001:2008 sets out the criteria for a quality management system',
                               :regulatory_review_name => 'ISO 9001:2008 - Continual Improvement Checklist',
                               :frequency => 'Annual'.force_encoding('UTF-8'),                            
                               :objectives => "The organization must have in place suitable methods for supporting continual improvement of its QMS.  Describe the organization's QMS improvement methods. Note any exceptions to the organization's QMS policy and report to the appropriate person for corrective action.  When you identify a means to improve a method, document your findings and forward to the appropriate person.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "General Requirements - Measurement, Analysis and Improvement",
:instructions => <<EOT
<ol><li>Describe the processes within your organization to continually improve the effectiveness of its QMS.<br></li><li>Identify evidence of improvement. If there is no evidence of improvement, explain why.<br></li><li>Describe the statistical tools used within the organization to analyze data.<br></li><li>Provide evidence that these statistical tools are being used appropriately.</li></ol>

EOT
}

tasks << {
:name => "Customer Satisfaction",
:instructions => <<EOT
<ol><li>Describe how your organization measures and monitors its customers' perception of whether the organization has met their requirements.<br></li><li>Identify evidence that customer satisfaction data is being collected properly. If there is no evidence of customer satisfaction monitoring, explain why.<br></li><li>Identify the individual who evaluates customer satisfaction data and whether or not action is required. Verify that the responsibility to initiate corrective or preventive action is clearly defined and understood.<br></li><li>List actions that have been taken as a result of customer satisfaction data. Review records describing what actions were taken and verify that the actions taken were appropriate.</li></ol>

EOT
}

tasks << {
:name => "Internal Audits",
:instructions => <<EOT
<ol><li>Describe the QMS internal audit process at your organization. Include in this description:<br><ol start="1" style="list-style-type: lower-alpha;"><li>How internal QMS audits are planned and conducted;<br></li><li>How they are documented;<br></li><li>How any required corrections and corrective actions are documented and monitored.<br></li></ol></li><li>Obtain the internal audit schedule for the previous year. Confirm that audits were scheduled based on the status and importance of the process and based on previous audit results.<br></li><li>Select a sampling of audit reports at random from the previous year and verify that they were conducted in accordance with the QMS internal audit schedule. Use these audit reports for the remainder of the items in this Task.<br></li><li>Describe how auditors are qualified. Include in the workspace below training records for the auditors who performed the above audits to verify that that they were qualified for the procedure. If they were not qualified, note this issue and report it to the appropriate person.<br></li><li>Confirm with auditors, or verify by other means, that they did not audit their own work.<br></li><li>Verify that auditors documented evidence of both conformance and non-conformance.<br></li><li>Explain how audit results are presented to the individual(s) who are responsible for the process that was audited.<br></li><li>Review and describe how internal audit findings of nonconformance were corrected in a timely manner.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Was the cause of the problem identified?<br></li><li>Was action taken to eliminate the cause?<br></li><li>Was the action taken effective?<br></li><li>Were associated documents updated and a result of the action?<br></li><li>Was the action promptly completed?<br></li></ol></li><li>List specific improvements to the business that resulted from the internal audit process.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Is there anything, in your opinion, that could be done to improve the effectiveness of the internal audits that would result in improvements to the business?</li></ol></li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
