# encoding: UTF-8
puts "Creating Conflict Minerals RCOI ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('SEC'),
                               :full_name => 'Conflict Minerals, Section 1502 of the Dodd-Frank Wall Street Reform and Consumer Protection Act',
                               :display_name => 'Conflict Minerals',
                               :description => 'Section 1502 of the Dodd-Frank Act requires public companies to provide disclosures relating to Conflict Minerals (gold, tin, tantalum, and tungsten) used in the products they manufacture. The intent of the Dodd-Frank mandate is to curb violence and human rights abuses in the Democratic Republic of the Congo (the "DRC") and its adjoining countries (collectively, the "Covered Countries") that may be fueled by proceeds from trade in these minerals through required disclosure, consumer transparency and public pressure on companies that source Conflict Minerals from the region.',
                               :regulatory_review_name => 'Conflict Minerals RCOI',
                               :frequency => 'Quarterly'.force_encoding('UTF-8'),                            
                               :objectives => "Firm's who determine that they are subject to the Conflict Minerals rules must conduct, in good faith, a Reasonable Country of Origin Inquiry (RCOI) that is designed to determine whether their Conflict Minerals originated in the Covered Countries or are from recycled or scrap sources. Conduct a RCOI for each Conflict Mineral used in the Firm's products based upon the Firm's latest \"Products Containing Conflict Mineral Listing for MM/DD/YYYY to MM/DD/YYYY\" as documented in the most recent Regulatory Review: Determine If the Firm Is Required To File Form SD.".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Conflict Minerals Supplier Log",
:instructions => <<EOT
<p>Conflict Minerals Supplier Log Update the Firm's "Suppliers of Conflict Minerals and Products Containing Conflict Materials Log" (the Log) for the previous quarter. Ensure that for each Supplier, the following information is current:&nbsp;</p><ol><li>Supplier's Name and Contact Information;<br></li><li>Supplier's Representative responsible for Conflict Mineral Reporting and Contact Information;<br></li><li>Conflict Minerals and/or Products Containing Conflict Minerals supplied to your Firm;<br></li><li>Location of Supplier-related Purchase Order Files;<br></li><li>URL of Supplier's public Conflict Materials Report or Description of RCOI and/or Form SD, if available.</li></ol>

EOT
}

tasks << {
:name => "Conduct in Good Faith an RCOI for Each Conflict Mineral from Each Supplier in the Log",
:instructions => <<EOT
<p>Conduct in Good Faith an RCOI for Each Conflict Mineral from Each Supplier in the Log<br></p><ol><li>Contact each Supplier's Conflict Mineral's representative to obtain the most recent RCOI Report or equivalent<br><ol start="1" style="list-style-type: lower-alpha;"><li>Note the response (or lack thereof) you receive.<br></li></ol></li><li>Review the format of each Report to ensure that it contains all the information listed in the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement.<br></li><li>Review each Supplier's Report disclosing the origin of its Conflict Materials and make a determination if the report was conducted in good faith.<br><ol start="1" style="list-style-type: lower-alpha;"><li>If you have any questions about a Supplier's Report, contact the Supplier's Conflict Minerals Representative, discuss your concerns and document the conversation. If appropriate, follow-up with written correspondence.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Prepare an RCOI Report for Your Firm",
:instructions => <<EOT
<p>Prepare an RCOI Report for Your Firm<br></p><ol><li>Create your Firm's RCOI Report using your Firm's version of the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement.<br><ol start="1" style="list-style-type: lower-alpha;"><li>For instructions on how to create this declaration statement, go to YouTube instruction video on how to use the MRPRO Dashboard<br></li><li>You must take into account the "reasonableness" of each Supplier's RCOI. (For a discussion of what is meant by "reasonableness," refer in the Reference Materials section at the end of this worksheet to Reasonable Country of Origin Inquiry.)</li></ol></li></ol>

EOT
}

tasks << {
:name => "Determine If Conflict Minerals Are Sourced From Scrap or Recycled Materials",
:instructions => <<EOT
<p>Determine If Conflict Minerals Are Sourced From Scrap or Recycled Materials<br></p><ol><li>Based upon the RCOI Report prepared in Task 3, does the Firm know, or reasonably believe, that ALL the Firm's Conflict Minerals come from scrap or recycled materials?<br><ol start="1" style="list-style-type: lower-alpha;"><li>If "NO," note the reason why and continue to Task 5.<br></li><li>If "YES" and this is NOT the first RCOI review of the Calendar Year, create a memo describing the results of the RCOI Report and close this Task.<br></li><li>If "YES" and this is the first RCOI review of the Calendar Year, as described next in Instruction 2.<br></li></ol></li><li>If 1b is "YES" and this is the first RCOI review of the Calendar Year, prepare a "Description of the Firm's RCOI Report" describing how the Firm conducted its RCOI. Note that this Report will be disclosed publicly.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Following the Firm's internal policies, obtain/create a Draft Report, Description of the Firm's RCOI.<br></li><li>Review the Firm's Draft Description of the Firm's RCOI with an appropriate outside expert, such as an attorney or regulatory consultant. Modify as appropriate.<br></li><li>Obtain internal executive approval to finalize, publish and file the Firm's Description of the Firm's RCOI.<br></li><li>Publish the Description of the Firm's RCOI on the Firm's website for one year.<br></li><li>Complete the Regulatory Review: Prepare and File Form SD with the SEC on an Annual Basis.</li></ol></li></ol>

EOT
}

tasks << {
:name => "Determine If The Firm Has Reason To Believe That Its Conflict Minerals May Have Originated In the DRC or an Adjoining Country.",
:instructions => <<EOT
<p>Determine If The Firm Has Reason To Believe That Its Conflict Minerals May Have Originated In the DRC or an Adjoining Country.<br></p><ol><li>Based upon the RCOI Report prepared in Task 3, does the Firm know, or reasonably believe, that ANY of the Firm's Conflict Minerals came from the DRC or an adjoining country?<br><ol start="1" style="list-style-type: lower-alpha;"><li>If "YES" and this is the last RCOI review of the Calendar Year, document your findings, close this Task and Complete the Regulatory Review: Perform Due Diligence on Your Firm's Supply Chain.<br></li><li>If "YES" and this is NOT the last RCOI review of the Calendar Year, document your findings and close this Task.<br></li><li>If "NO," prepare a "Description of the Firm's RCOI Report" as described next in Instruction 2.<br></li></ol></li><li>If "NO," prepare a "Description of the Firm's RCOI Report" describing how the Firm conducted its RCOI. Note that this Report will be disclosed publicly.<br><ol start="1" style="list-style-type: lower-alpha;"><li>Following the Firm's internal policies, obtain/create a Draft Report, Description of the Firm's RCOI.<br></li><li>Review the Firm's Draft Description of the Firm's RCOI with an appropriate outside expert, such as an attorney or regulatory consultant. Modify as appropriate.<br></li><li>Obtain internal executive approval to finalize, publish and file the Firm's Description of the Firm's RCOI.<br></li><li>Publish the Description of the Firm's RCOI on the Firm's website for one year.<br></li><li>Complete the Regulatory Review: Prepare and File Form SD with the SEC on an Annual Basis.</li></ol></li></ol>

EOT
}


template.tasks = tasks.to_json
template.save!
