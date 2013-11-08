# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Establish Strong Company Management Systems ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Non-Filing Electronics Industry Manufacturers: Establish Strong Company Management Systems',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To ensure that existing due diligence and management systems within companies address risks associated with minerals from conflict affected or high-risk areas incorporating OECD (Organization for Economic Cooperation and Development) and industry association due diligence guidance.<br />
<em style=\"line-height: 1.6em;\">The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Identify Lead for Conflict Minerals Reporting",
:instructions => <<EOT
<ol>
	<li>Provide the name, title, department and contact information for the Firm&rsquo;s Lead for Conflict Minerals Reporting.</li>
	<li>Describe this individual&rsquo;s qualifications to be the Firm&rsquo;s Conflict Minerals Reporting Lead.</li>
	<li>Attach the Lead&rsquo;s career profile.</li>
	<li>If the Lead is not responsible for addressing questions on the Conflict Minerals Rule for the Firm, record the Firm&rsquo;s spokesperson and contact information for responding to customer, supplier, media, investor, and public Conflict Mineral-related questions.</li>
</ol>

EOT
}

tasks << {
:name => "Form Conflict Minerals Reporting Oversight Committee",
:instructions => <<EOT
<ol>
	<li>Attach the Committee&rsquo;s Charter, including authority and responsibilities.&nbsp; The Charter should include review and approval of:
	<ol style="list-style-type:lower-alpha;">
		<li>The process for determining scope of which products and components are applicable;</li>
		<li>Written conflict minerals internal process and standards/norms;</li>
		<li>The Firm&#39;s Conflict Minerals Policy;</li>
		<li>Conflict minerals reporting tools;</li>
		<li>FAQ&rsquo;s regarding conflict minerals reporting;</li>
		<li>Which executive signs off on final reports;</li>
		<li>Staffing for conflict minerals reporting;</li>
		<li>Internal conflict minerals reporting communication plan;</li>
		<li>Conflict minerals language terms and conditions for supplier contracts;</li>
		<li>Responses to customer inquiries;</li>
		<li>RCOI data gathering process and final report;</li>
		<li>Due Diligence Report;</li>
		<li>Annual Conflict Minerals Report in a format similar to that required for SEC Form SD to be provided to downstream customers, some of whom many be filers;</li>
		<li>Any additional conflict minerals due diligence and reporting issues that require the Firm&rsquo;s management oversight.</li>
	</ol>
	</li>
	<li>Record the name, title, department and contact information for each member of the Conflict Minerals Reporting Oversight Committee.</li>
	<li>Describe the criteria for selecting Committee members.</li>
	<li>Ensure that the Committee includes executives who can represent manufacturing, engineering, procurement, IT, finance, and legal.</li>
	<li>If the Committee is supported by outside counsel and/or consultants, identify them and include the scope and objective of their participation.</li>
	<li>Publish the schedule of meeting dates and times for the current and upcoming calendar years.</li>
</ol>

EOT
}

tasks << {
:name => "Participate in industry association groups (e.g. IPC, EICC, AIAG, NAM)",
:instructions => <<EOT
<ol>
	<li>Identify the industry association groups with which the Firm currently has a membership and that have an active Conflict Minerals initiative.
	<ol style="list-style-type:lower-alpha;">
		<li>For each industry association, list the Firm&rsquo;s representative and the representative&rsquo;s contact information.</li>
	</ol>
	</li>
	<li>Describe the Firm&rsquo;s conflict minerals related activities with each association.&nbsp; Activities may include participating with working groups, completing training courses, responding to surveys, attending seminars/webinars, using resources, adopting tools, requesting advice/guidance, etc.</li>
</ol>

EOT
}

tasks << {
:name => "Create database to manage supplier and customer conflict minerals reporting communications ",
:instructions => <<EOT
<ol>
	<li>Establish a central database of supplier personnel, including title and contact information, who are the spokesperson for their company&rsquo;s conflict minerals reporting.&nbsp; If a supplier has designated a conflict minerals reporting office/program, as opposed to an individual, ensure that the appropriate email address is included.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that the database has the ability to maintain your Firm&rsquo;s correspondence with its suppliers and their responses.&nbsp; Assume the majority of communications will be by email.</li>
		<li>Include all your material, product and component suppliers, including those whose offerings may not appear to include conflict minerals.</li>
		<li>Confirm by individual email that each supplier&rsquo;s email address is correct and that each has the authority to provide your Firm with its Reasonable Country of Origin Inquiry (RCOI) and Conflict Minerals Due Diligence Reports.</li>
		<li>Ensure that each supplier is identified using its unique headquarters location DUNS number. &nbsp;Make certain that supplier divisions or satellite locations are not categorized as separate suppliers in your Firm&rsquo;s conflict minerals supplier database.</li>
	</ol>
	</li>
	<li>Establish a central database of customer personnel, including title and contact information, who are the Leads for their company&rsquo;s conflict minerals reporting.&nbsp; If a customer has designated a conflict minerals reporting office/program as opposed to an individual, ensure that the appropriate email address is included.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that the database has the ability to maintain your Firm&rsquo;s correspondence with its customers and their responses.</li>
		<li>Confirm by individual email that each customer&rsquo;s email address is correct and that each acknowledges your Firm&rsquo;s conflict minerals reporting program and contact information.</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Determine scope of which products and components are applicable",
:instructions => <<EOT
<ol>
	<li>Identify the products your Firm manufactures and components it purchases from upstream suppliers that may contain conflict minerals.
	<ol style="list-style-type:lower-alpha;">
		<li>If possible, use the Firm&rsquo;s centralized manufacturing database to identify and add a label/attribute identifying products and components containing conflict minerals.</li>
		<li>If your Firm does not have a centralized database, survey in writing knowledgeable individuals who are qualified to identify which products and components are likely to contain conflict minerals.</li>
		<li>Review purchasing and engineering specifications, purchase orders, material safety data sheets, material content data forms, and bill of materials to ensure the completeness of this effort.</li>
	</ol>
	</li>
	<li>Where possible, consider including the following conflict minerals information with all materials, products and components purchased and manufactured:
	<ol style="list-style-type:lower-alpha;">
		<li>Conflict minerals or derivatives used;</li>
		<li>Country of Origin, if known, of conflict minerals;</li>
		<li>If the minerals are &ldquo;DRC Conflict Free&rdquo; and the basis for the claim;</li>
		<li>Additional information, such as smelter certification or proof of mine-of-origin.</li>
	</ol>
	</li>
	<li>Document the process you followed for determining which products and components contain conflict minerals and report to the Conflict Minerals Reporting Oversight Committee.
	<ol style="list-style-type:lower-alpha;">
		<li>Describe the potential risk in the process used for identifying the components containing conflict minerals.&nbsp; For example, components containing conflict minerals may not have been identified due to a lack of knowledge of the composition of all components.</li>
		<li>Recommend methods for improving the Firm&rsquo;s process of identifying products and components that contain conflict minerals.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Establish internal expertise on Conflict Minerals Rule (Section 1502 Dodd-Frank Act and SEC Final Rule), EICC-GeSI Conflict Minerals Reporting Template and OECD Due Diligence Guidelines ",
:instructions => <<EOT
<ol>
	<li>Review the conflict minerals reference materials available on line.&nbsp; Excellent resource centers include <a href="http://www.srz.com/Conflict_Minerals_Resource_Center/">SRZ&#39;s Conflict Minerals Resource Center</a>, <a href="http://www.ipc.org/ContentPage.aspx?pageid=Conflict-Minerals-Resources-for-the-Electronics-Industry">IPC&rsquo;s Conflict Minerals Resources for the Electronics Industry</a>, <a href="http://www.oecd.org/fr/daf/inv/mne/mining.htm">OECD Documents and Links</a>, <a href="http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm">EICC-GeSI Conflict Minerals Reporting Template &amp; Dashboard</a>, and <a href="http://www.eicc.info/Extractives.shtml">EICC GeSI Extractives and Conflict Minerals Resources</a>.</li>
	<li>Attend a conflict minerals reporting seminar.</li>
	<li>Survey your customers, starting with publically traded US corporations, to identify what conflict minerals reporting resources they are prepared to provide to your Firm as a supplier.&nbsp; Note that they may provide RCOI (Reasonable Country of Origin Inquiry) reporting and OECD-based due diligence training classes; they may recommend automated supply chain reporting tools.</li>
	<li>Consider engaging a consulting firm and/or outside counsel that is expert with the Conflict Minerals Rule requirements to review your Firm&rsquo;s specific situation and provide guidance.&nbsp;</li>
</ol>

EOT
}

tasks << {
:name => "Develop and distribute supplier communication",
:instructions => <<EOT
<ol>
	<li>Email a written communication to the supplier personnel in the database created in Task 4 informing them of the Firm&rsquo;s compliance obligations under the Conflict Minerals rule.&nbsp;
	<ol style="list-style-type:lower-alpha;">
		<li>An example of a non-filer Firm&rsquo;s first email communications to its suppliers is:<br />
		<br />
		<em>Date:</em></li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.0in;"><em>Subject: Conflict Minerals</em></p>

<p style="margin-left:1.0in;"><em>To: FIRM Suppliers</em></p>

<p style="margin-left:1.0in;"><em>On August 22, 2012, the U.S. Securities and Exchange Commission (&ldquo;SEC&rdquo;) adopted final rules to implement reporting and disclosure requirements related to &ldquo;conflict minerals,&rdquo; as directed by the Dodd-Frank Wall Street Reform and Consumer Protection Act of 2010.&nbsp; The rules require manufacturers who file certain reports with the SEC to disclose whether the products they manufacture or contract to manufacture contain &ldquo;conflict minerals&rdquo; that are &ldquo;necessary to the functionality or production&rdquo; of those products.</em></p>

<p style="margin-left:1.0in;"><em>&ldquo;Conflict minerals&rdquo; refers to gold, as well as tin, tantalum, and tungsten, the derivatives of cassiterite, columbite-tantalite, and wolframite, regardless of where they are sourced, processed or sold.&nbsp; The U.S. Secretary of State may designate other minerals in the future.&nbsp; The intent of these requirements is to further the humanitarian goal of ending violent conflict in the Democratic Republic of the Congo (DRC) and in surrounding countries, which has been partially financed by the exploitation and trade of conflict minerals.</em></p>

<p style="margin-left:1.0in;"><em>To ensure compliance with these requirements, each manufacturer in the supply chain must request information regarding the use of conflict minerals from their direct suppliers, who, in turn, must solicit that information from the next tier of suppliers.&nbsp; Therefore, the FIRM must impose new reporting requirements on its global supply chains, regardless of where the materials, components, and products are purchased.</em></p>

<ul>
	<li style="margin-left: 80px;"><em>The FIRM requires you to return a completed </em><a href="http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm"><em>Electronic Industry Citizenship Coalition and Global e-Sustainability Initiative (EICC-GeSI) Conflict Minerals Reporting Template</em></a><em>, including all smelter information for all of the designated minerals.&nbsp; </em></li>
	<li style="margin-left: 80px;"><em>Suppliers expected to provide products to the FIRM between January 1, 2013 through December 31, 2013 are required to submit initial company-level report on the use of &ldquo;conflict minerals&rdquo; by DATE<strong>. </strong></em></li>
	<li style="margin-left: 80px;"><em>Document all steps taken to collect and report &ldquo;conflict minerals&rdquo; information and preserve that documentation. </em></li>
</ul>

<p style="margin-left:1.0in;"><em>The materials you provide may be reviewed in an audit related to due diligence efforts to collect this information.&nbsp; The framework for this audit can be found in the </em><a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><em>OECD (2013), OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas, Second Edition</em></a><em>. We will be providing you with further guidance as to our requirements to minimize deficiencies in the event of an audit. </em></p>

<p style="margin-left:1.0in;"><em>Collecting and reporting information related to conflict minerals is expected to take months, so prompt action is critical. Once you provide conflict minerals data, any next steps required to address concerns in the supply chain will be handled on a company-by-company basis. We appreciate your immediate attention to this matter. </em></p>

<p style="margin-left:1.0in;"><em>Please reply to this email to both acknowledge your receipt and understanding of the requirements.&nbsp; If you have any Firm-specific questions on this subject, please contact the FIRM&rsquo;s [Conflict Minerals Reporting Spokesperson, email and phone number]. </em></p>

<p style="margin-left:1.0in;"><em>Signed by Firm&rsquo;s purchasing executive</em></p>

<ol style="list-style-type:lower-alpha;">
	<li value="2">Record in the database each supplier&rsquo;s response to your Firm&rsquo;s initial communication.&nbsp; (Follow up by phone and email with each supplier who has not initially responded within 5 working days.)</li>
</ol>

<ol>
	<li value="2">Develop a supplier policy regarding conflict minerals.
	<ol style="list-style-type:lower-alpha;">
		<li>An example of a Firm&rsquo;s conflict minerals policy regarding suppliers is:</li>
	</ol>
	</li>
</ol>

<p style="margin-left:.75in;"><em>Suppliers are expected to ensure that products and components supplied to the FIRM are DRC conflict-free.&nbsp; DRC conflict-free is defined as products and components that do not contain tantalum, tin, gold, or tungsten (or their derivatives) that finance or benefit armed groups through mining or mineral trading in the Democratic Republic of the Congo or an adjoining country.&nbsp; Suppliers to the FIRM must establish and document their adherence to policies, due diligence frameworks and management systems consistent with the <u>OECD (2013), OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas, Second Edition</u>, that are designed to accomplish our mutual goal of buying and selling only DRC conflict-free products and components.</em></p>

<ol style="list-style-type:lower-alpha;">
	<li value="2">Review the Firm&rsquo;s draft supplier policy with Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
</ol>

<ol>
	<li value="3">Email your Firm&rsquo;s conflict minerals supplier policy to all the supplier personnel identified in Task 4.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that the email message includes a statement that if your supplier has any questions, a conflict minerals knowledgeable supplier representative should contact your Firm&rsquo;s conflict minerals spokesperson for clarification.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Develop conflict minerals reporting policy",
:instructions => <<EOT
<ol>
	<li style="margin-left: 0.25in;">The Firm must prepare a written policy regarding the use of Conflict Minerals that it can communicate to employees, customers, suppliers and the public. This policy must be similar to that recommended by the OECD (2013) in <a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas</em></a>.&nbsp; (See Annex II, <em>Model Supply Chain Policy for a Responsible Global Supply Chain of Minerals from Conflict-Affected and High-Risk Areas</em>, page 20.)</li>
	<li style="margin-left: 0.25in;">Document approval of the Firm&#39;s policy by both the Conflict Minerals Oversight Reporting Committee and the Chief Executive Officer.</li>
	<li style="margin-left: 0.25in;">If your Firm&#39;s Conflict Mineral policy deviates significantly from the OECD&#39;s, document the reasons why.</li>
</ol>

EOT
}

tasks << {
:name => "Place the Firm’s conflict minerals policy on its website",
:instructions => <<EOT
<ol>
	<li style="margin-left: 0.25in;">Place the Firm&#39;s written Conflict Minerals Policy on the Firm&#39;s website with the page title Conflict Minerals Disclosure and ensure that it is readily accessible.</li>
	<li style="margin-left: 0.25in;">Record a screen shot clearly displaying the URL for documentation purposes.</li>
	<li style="margin-left: 0.25in;">If your Firm&#39;s website has search capability, document that entering the term &quot;Conflict Minerals&quot; returns the link to the Firm&#39;s written policy.&nbsp;</li>
</ol>

EOT
}

tasks << {
:name => "Provide internal training on Conflict Minerals Rule (Section 1502 Dodd- Frank Act), EICC-GeSI Conflict Minerals Reporting Template and OECD Due Diligence Guidelines",
:instructions => <<EOT
<ol>
	<li>Develop or purchase reporting training materials for the Firm.</li>
	<li>Review training materials and messages with Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
	<li>Conduct in-person internal training session(s) on the Conflict Minerals Rule, EICC-GeSI Conflict Minerals Reporting Template and OECD Due Diligence Guidelines for appropriate personnel. &nbsp;Document for each training session:
	<ol style="list-style-type:lower-alpha;">
		<li>Subject and objectives for session;</li>
		<li>Location, date and time;</li>
		<li>Instructor(s);</li>
		<li>Attendees, their contact information and, if testing conducted, test results;</li>
		<li>Materials/slides presented.</li>
	</ol>
	</li>
	<li>After each session document recommendations for improving the effectiveness of the training.</li>
</ol>

EOT
}

tasks << {
:name => "Create FAQs on conflict minerals reporting",
:instructions => <<EOT
<ol>
	<li>Create a proposed list of Frequently Asked Questions (FAQs) and their answers regarding conflict minerals reporting as it applies to your Firm.
	<ol style="list-style-type:lower-alpha;">
		<li>Review <a href="http://www.pwc.com/us/en/audit-assurance-services/conflict-minerals-faqs.jhtml"><em>PwC Conflict Minerals: Frequently Asked Questions</em></a> as model FAQ lists that can be modified to take into account your Firm&rsquo;s specific circumstances and requirements.</li>
	</ol>
	</li>
	<li>Review your Firm&rsquo;s proposed FAQs on conflict minerals reporting with the Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
	<li>In conjunction with the Conflict Minerals Reporting Oversight Committee, decide to whom and how to communicate the Firm&rsquo;s FAQs on conflict minerals reporting.
	<ol style="list-style-type:lower-alpha;">
		<li>Firm&rsquo;s should place their FAQs:
		<ul>
			<li>On their website under the &ldquo;Compliance Minerals Disclosure&rdquo; page for the public;</li>
			<li>On their intranet and as part of management training classes for employees;</li>
			<li>As an email attachment with the appropriate cover note for upstream suppliers whose conflict minerals contacts were obtained in Task 4.</li>
		</ul>
		</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Determine which executive will sign off on final report",
:instructions => <<EOT
<ol>
	<li>Prepare a list of executives who should be considered for signing off on the Firm&rsquo;s final conflict minerals reports.&nbsp; Include in this list the Firm&rsquo;s CEO, COO, CFO and VP Manufacturing Operations.</li>
	<li>Review the list with the Conflict Minerals Reporting Oversight Committee and select the executive with the most knowledgeable about the Firm&rsquo;s conflict minerals initiative.</li>
	<li>Provide the name, title, department and contact information for the executive officer who will have the responsibility for signing off on the Firm&rsquo;s final conflict minerals reports.</li>
	<li>Describe the reasons this individual is most qualified to sign off on the Firm&rsquo;s final conflict minerals reports.</li>
</ol>

EOT
}

tasks << {
:name => "Provide supplier training on reporting process, (if appropriate for your Firm.)",
:instructions => <<EOT
<ol>
	<li>Prepare a training session explaining your Firm&rsquo;s conflict minerals policy, stating information input requirements (Reasonable Country of Origin Inquiry report and Conflict Minerals Due Diligence report) from its upstream suppliers, describing the format these reports must be in and the information included, when and to whom these reports must be provided to your Firm, how these reports will be used, and your Firm&rsquo;s policy on protecting the confidential information that may be contained in the reports.</li>
	<li>Review the proposed supplier training agenda and content on conflict minerals reporting with the Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
	<li>Invite all the suppliers identified in Task 4 to attend the training session in person at your facility.
	<ol style="list-style-type:lower-alpha;">
		<li>Record the training session.</li>
		<li>Document who attended.</li>
	</ol>
	</li>
	<li>Using streaming video, make the supplier training session available to all your Firm&rsquo;s suppliers identified in Task 4 and the appropriate internal personnel.</li>
</ol>

EOT
}

tasks << {
:name => "Design and implement a strategy to respond to identified risk",
:instructions => <<EOT
<ol>
	<li>Meet with your strategic customers one-on-one with the objective of identifying risks in your conflict minerals reporting strategy.
	<ol style="list-style-type:lower-alpha;">
		<li>Review your Firm&rsquo;s conflict minerals policy, reporting (including upstream supplier reporting requirements) and communications procedures, and key personnel.</li>
		<li>Request similar information from your customers.
		<ul>
			<li>Note that if a customer cannot provide similar information, this may be the indication of a risk for your Firm as your customer may be incurring additional market risk.</li>
		</ul>
		</li>
		<li>Ask your customers to identify potential risks in your conflict minerals reporting program.</li>
		<li>Prepare a Conflict Minerals Market Risk Analysis for your Firm based upon these customer interviews.</li>
	</ol>
	</li>
	<li>Develop procedures for suspending or terminating suppliers that do not comply with your Firm&rsquo;s conflict minerals policy and reporting requirements.
	<ol style="list-style-type:lower-alpha;">
		<li>Identify alternative sources for materials, products, and components containing conflict minerals.</li>
	</ol>
	</li>
	<li>Survey your customers to compare your Firm&rsquo;s conflict minerals&rsquo; policy and supplier practices with industry norms to ensure that you are not incurring unacceptable market risk.</li>
	<li>If risks relating to the Conflict Minerals Rule appear to be significant, prepare a risk factor statement describing the uncertainties and how these uncertainties might negatively impact your Firm.</li>
	<li>Review the results of the work effort performed with the Conflict Minerals Reporting Oversight Committee in a timely manner and modify the Firm&rsquo;s strategy to respond to identified risks as recommended.</li>
	<li>Communicate the identified risks and recommended responses to senior management.</li>
</ol>

EOT
}

tasks << {
:name => "Assess adequate staffing for conflict minerals reporting activities",
:instructions => <<EOT
<ol>
	<li>Consider whether one or more additional internal hires are needed to manage the Conflict Minerals Rule compliance program.</li>
	<li>Consider whether the internal team needs to be supplemented by specialist outside counsel. Outside counsel can assist in:
	<ol style="list-style-type:lower-alpha;">
		<li>Developing the compliance program;</li>
		<li>Educating personnel on the requirements of the Conflict Minerals Rule;</li>
		<li>Advising on interpretive questions and gray areas under the rule (there are many);</li>
		<li>Preparing compliance policies, supplier communications, questionnaires, certifications and contract modifications;</li>
		<li>Reviewing and advising on incoming materials from suppliers and customers;</li>
		<li>Preparing Conflict Minerals Rule disclosure.</li>
	</ol>
	</li>
	<li>Consider the need for outside consultants.&nbsp; Consultants can assist in:
	<ol style="list-style-type:lower-alpha;">
		<li>Analyzing the supply chain and supply chain risk;</li>
		<li>Developing and assessing the effectiveness of diligence procedures;</li>
		<li>Advising on and implementing enhancements to the Firm&rsquo;s supply chain management program.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Develop internal communication plan",
:instructions => <<EOT
<ol>
	<li>Identify the employees within your Firm who should be included in all internal conflict minerals reporting communications.
	<ol style="list-style-type:lower-alpha;">
		<li>Maintain this list in an accessible and secure location.</li>
	</ol>
	</li>
	<li>Send an initial written communication to the appropriate employees informing them about the Conflict Minerals Rule, the Firm&rsquo;s compliance obligations under the rule (including key reporting dates), compliance policy, and executives charged with documenting compliance.
	<ol style="list-style-type:lower-alpha;">
		<li>Provide links to the Firm&rsquo;s Conflict Minerals Reporting FAQs.</li>
	</ol>
	</li>
	<li>Send subsequent written communications to the appropriate employees every 3 months, or when major conflict mineral events occur, updating them about the status of the Firm&rsquo;s conflict minerals reporting program and regulatory requirements.</li>
	<li>Update the Firm&rsquo;s compliance manuals and policies to reflect the Conflict Minerals Rule and the Firm&rsquo;s compliance policy.</li>
</ol>

EOT
}

tasks << {
:name => "Add conflict minerals terms and conditions to supplier contracts",
:instructions => <<EOT
<ol>
	<li>The Firm should include conflicts minerals language to its standard supplier contracts.&nbsp; The Firm has many options in adding conflict minerals language to its supplier contracts. &nbsp;The criteria for selecting an approach should be to select wording that best meets the requirements of its customers and their downstream customers.&nbsp; Examples of three different approaches are:
	<ol style="list-style-type:lower-alpha;">
		<li>Purchaser&rsquo;s contract may require suppliers to agree to maintaining adherence to the customer&rsquo;s supply chain policy, allow for inspection rights, detail supplier disclosure, reporting and cooperation rights, and require similar flow-down clauses of the Firm&rsquo;s suppliers&rsquo; suppliers.&nbsp; For example: &nbsp;<em>Suppliers must have a Conflict Minerals policy. &nbsp;Smelter information from Supplier and Supplier&#39;s supply chain must be disclosed and updated using the EICC-GeSI Conflict Minerals Reporting Template for any conflict mineral used in, or used in the production of, parts, materials, components and products. &nbsp;When Firm notifies Supplier that there are sufficient Conflict-Free Smelters (CFS) available, any conflict mineral used in, or used in the production of, parts, materials, components and products must be sourced from a CFS. </em>&nbsp;<em>When </em><em>&ldquo;Conflict-free</em><em>&rdquo; or </em><em>&ldquo;DRC conflict-free</em><em>&rdquo; is specified in the Firm</em><em>&rsquo;s product or component specifications, Supplier is responsible for gathering reports from its supply chain demonstrating that any conflict mineral used in, or used in the production of, parts, materials, components and products must be sourced from a Compliant Conflict-Free Smelter, listed on the Conflict-Free Smelter (CFS) Program webpage.</em></li>
		<li>Yet another approach is to put in broad standard language that is subject to interpretation, such as: <em>Supplier shall adopt policies and establish systems to procure tantalum, tin, tungsten, or gold from sources that have been verified as conflict free, and provide supporting data to Purchaser on its supply chains for tantalum, tin, tungsten, and/or gold when requested.</em></li>
		<li>For small-to-medium sized manufacturers serving larger manufacturers, a good choice might be: <em>Suppliers who manufacture materials, components, parts, or products containing tin, tantalum, tungsten, and/or gold shall define, implement and communicate to sub-suppliers their own Conflict Mineral Policy, outlining their commitment to responsible sourcing and measures for implementation.&nbsp; Suppliers shall work with sub-suppliers to ensure traceability of these metals at least to the smelter level.&nbsp; Traceability data shall be maintained and recorded for 5 years and provided to the Firm upon request.&nbsp; Once such mechanisms are available, suppliers shall ensure that purchased metals originate from smelters validated by Suppliers as being conflict mineral free.&nbsp; Suppliers are encouraged to support industry efforts to enhance traceability and responsible practices in global minerals supply chains.</em></li>
	</ol>
	</li>
	<li>Once a rationale for the conflict minerals wording to be added to supplier contracts has been decided upon and approved by both the Conflict Minerals Reporting Oversight Committee and Purchasing Department, the Firm should engage an attorney with experience both in the conflict minerals area and contract law to construct the appropriate wording for inclusion in the Firm&rsquo;s supplier contracts.</li>
	<li>Ensure that all new supplier contracts include the requirements to support the Firm&rsquo;s conflict minerals policy and reporting requirements.</li>
</ol>

EOT
}

tasks << {
:name => "Establish and publish internal processes and standards/norms",
:instructions => <<EOT
<ol>
	<li>Ensure that the processes the Firm is implementing for Establishing Strong Company Management Systems; Identify and Assess Risk in the Supply Chain; Design and implement a strategy to respond to identified risk; Third Party Audit of Smelters/Refiners Due Diligence Practices; and Report Annually on Supply Chain Due Diligence are adequately documented in order that they will meet the Firm&rsquo;s suppliers mandates, may be replicated in subsequent years and can effectively reported in the Firm&rsquo;s Due Diligence Report.</li>
	<li>When potential improvements in the Firm&rsquo;s conflict minerals reporting and due diligence process are identified, bring them to the attention of the Conflict Minerals Reporting Oversight Committee for appropriate action.</li>
	<li>Upon the completion of all the internal conflict minerals reporting and due diligence tasks except this one, provide the Conflict Minerals Reporting Oversight Committee with a draft report/manual of the Firm&rsquo;s current internal processes and standards/norms for its approval and/or improvements.</li>
	<li>When approved, publish as a company document entitled, <em>Firm</em><em>&rsquo;s Conflict Minerals Reporting and Due Diligence Manual</em>, Date Published.</li>
	<li>Ensure that the Firm&rsquo;s current Conflict Minerals Reporting and Due Diligence Manual is included in the Firm&rsquo;s regulatory and standards library and is a part of the appropriate training courses.</li>
	<li>Ensure that the Firm&rsquo;s current Conflict Minerals Reporting and Due Diligence Manual is provided to all employees whose job functions require it.</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!
