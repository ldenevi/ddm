# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Auto Industry Manufacturers: AIAG 1.00 Establish Strong Company Management Systems ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => '[OLD] Conflict Minerals, Section 1502 of the Dodd-Frank Wall Street Reform and Consumer Protection Act',
                               :display_name => 'Conflict Minerals',
                               :description => 'Section 1502 of the Dodd-Frank Act requires public companies to provide disclosures relating to Conflict Minerals (gold, tin, tantalum, and tungsten) used in the products they manufacture.  The intent of the Dodd-Frank mandate is to curb violence and human rights abuses in the Democratic Republic of the Congo (the “DRC”) and its adjoining countries (collectively, the “Covered Countries”) that may be fueled by proceeds from trade in these minerals through required disclosure, consumer transparency and public pressure on companies that source Conflict Minerals from the region.',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Auto Industry Manufacturers: AIAG 1.00 Establish Strong Company Management Systems',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong><span style=\"font-size:12px;\"> To ensure that existing due diligence and management systems within companies address risks associated with minerals from conflict affected or high-risk areas incorporating OECD (Organization for Economic Cooperation and Development) and industry association due diligence guidance.</span><br />
<span style=\"font-size:11px;\"><em style=\"line-height: 1.6em;\">The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></span></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Identify Lead for Conflict Minerals Reporting",
:instructions => <<EOT
<ol>
	<li>Provide the name, title, department and contact information for the firm&rsquo;s Lead for Conflict Minerals Reporting.</li>
	<li>Describe this individual&rsquo;s qualifications to be the firm&rsquo;s Conflict Minerals Reporting Lead.</li>
	<li>Attach the Lead&rsquo;s career profile.</li>
	<li>Is the Lead authorized to address questions on the Conflict Minerals Rule for the firm?&nbsp; If not, who is the firm&rsquo;s point person for addressing Conflict Mineral&rsquo;s related questions?</li>
	<li>Identify all additional employees whose primary job function is to support the firm&rsquo;s Conflict Minerals compliance program.</li>
</ol>

<p>&nbsp;</p>


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
		<li>The firm&#39;s Conflict Minerals Policy;</li>
		<li>Conflict minerals reporting tools;</li>
		<li>Supplier training on reporting tools;</li>
		<li>FAQ&rsquo;s regarding conflict minerals reporting;</li>
		<li>Which executive signs off on the final reports, including Form SD approval, the firm&rsquo;s Due Diligence report and Reasonable Country of Origin Inquiry;</li>
		<li>Staffing for conflict minerals reporting;</li>
		<li>Internal conflict minerals reporting communication plan;</li>
		<li>Conflict minerals language terms and conditions for supplier contracts.</li>
	</ol>
	</li>
	<li>Provide the name, title, department and contact information for each member of the Conflict Minerals Reporting Oversight Committee.</li>
	<li>Describe the criteria for selecting Committee members.</li>
	<li>If the Committee does not include representatives from manufacturing, engineering, procurement, IT, finance, internal audit and legal, state the reason why.</li>
	<li>If the Committee is supported by outside counsel and/or consultants, identify them and include the scope and objective of their participation.</li>
</ol>


EOT
}

tasks << {
:name => "Participate in industry association groups (e.g. AIAG, EICC)",
:instructions => <<EOT
<ol>
	<li>Identify the industry association groups with which the firm currently has a membership and that have an active Conflict Minerals initiative.
	<ol style="list-style-type:lower-alpha;">
		<li>For each industry association, list the firm&rsquo;s representative and the representative&rsquo;s contact information.</li>
	</ol>
	</li>
	<li>Describe the firm&rsquo;s conflict minerals related activities with each association.&nbsp; Activities may include participating with working groups, completing training courses, responding to surveys, attending seminars/webinars, using resources, adopting tools, requesting advice/guidance, etc.</li>
</ol>


EOT
}

tasks << {
:name => "Create process for supplier questions (E-Mail address)",
:instructions => <<EOT
<ol>
	<li>Establish a central database of supplier personnel, including title and contact information, who are the lead/point person for their company&rsquo;s conflict minerals reporting.&nbsp; If a supplier has designated a conflict minerals reporting office/program as opposed to an individual, ensure that the appropriate e-mail address is included.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that the database has the ability to track your firm&rsquo;s correspondence with its suppliers and their responses.</li>
	</ol>
	</li>
	<li>Confirm by individual e-mail that each supplier&rsquo;s e-mail address is correct and that each has the authority to provide your firm with its Reasonable Country of Origin Inquiry (RCOI) and Conflict Minerals Due Diligence Reports.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Determine scope of which products and components are applicable",
:instructions => <<EOT
<ol>
	<li>Identify the products your firm manufactures and components it purchases from upstream suppliers that may contain conflict minerals.
	<ol style="list-style-type:lower-alpha;">
		<li>If possible, use the firm&rsquo;s centralized manufacturing database to identify and add a label/attribute identifying products and components containing conflict minerals.</li>
		<li>If your firm does not have a centralized database, survey in writing knowledgeable individuals who are qualified to identify which products and components contain conflict minerals.</li>
	</ol>
	</li>
	<li>Document the process you followed for determining which products and components contain conflict minerals and report to the Conflict Minerals Reporting Oversight Committee.
	<ol style="list-style-type:lower-alpha;">
		<li>Describe the potential risk in the process used for identifying the components containing conflict minerals that components containing conflict minerals may not have been identified.</li>
		<li>Recommend methods for improving the firm&rsquo;s process of identifying products and components that contain conflict minerals</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Obtain conflict minerals reporting tool (e.g. iPoint)",
:instructions => <<EOT
<ol>
	<li style="margin-left: 0.25in;">Sign up for an iPoint webinar to understand the advantages of participating in the auto industry&#39;s initiative to map the supply chain.</li>
	<li style="margin-left: 0.25in;">Enroll in an iPoint training course and/or engage an iPoint consultant to prepare for implementing iPoint&#39;s iPCMP application.</li>
	<li style="margin-left: 0.25in;">Prepare an IPoint implementation plan.</li>
	<li style="margin-left: 0.25in;">Review the implementation plan with the Conflict Minerals Oversight Reporting Committee and modify as recommended.</li>
	<li style="margin-left: 0.25in;">Acquire the appropriate license from iPoint.</li>
	<li style="margin-left: 0.25in;">Implement a pilot project to validate assumptions in the current plan.</li>
	<li style="margin-left: 0.25in;">7Based upon the findings of the pilot project, evaluate the risks and advantages of implementing iPoint for all products and components identified in Task&nbsp;5.</li>
	<li style="margin-left: 0.25in;">Review findings with the Conflict Minerals Oversight Reporting Committee and, if appropriate, request approval to implement iPCMP throughout the entire firm.</li>
	<li style="margin-left: 0.25in;">If iPCMP is not appropriate for your firm&#39;s situation, recommend an alternative reporting method and procedure.</li>
</ol>

<p>&nbsp;</p>

<p style="margin-left:.25in;">&nbsp;</p>


EOT
}

tasks << {
:name => "Develop and distribute supplier communication",
:instructions => <<EOT
<ol>
	<li>Send a written communication to the supplier personnel in the database created in Task 4 informing them of the firm&rsquo;s compliance obligations under the Conflict Minerals rule.&nbsp; AIAG&rsquo;s <a href="http://www.aiag.org/staticcontent/committees/download_files/download.cfm?fname=Template%20Letter_to_Suppliers_FINAL11-8-12.pdf">supplier communication template</a> is an excellent example that can be modified for your firm&rsquo;s specific requirements.</li>
	<li>Record in the database each supplier&rsquo;s response to your firm&rsquo;s written communication.
	<ol style="list-style-type:lower-alpha;">
		<li>Follow up by phone and e-mail with each supplier who has not responded within 5 working days.</li>
	</ol>
	</li>
	<li>Develop a supplier policy regarding conflict minerals.
	<ol style="list-style-type:lower-alpha;">
		<li>An example of a firm&rsquo;s conflict minerals policy regarding suppliers is:</li>
	</ol>
	</li>
</ol>

<p style="margin-left:.75in;"><em>Suppliers are expected to ensure that products and components supplied to the FIRM are DRC conflict-free.&nbsp; DRC conflict-free is defined as products and components that do not contain tantalum, tin, gold, or tungsten (or their derivatives) that finance or benefit armed groups through mining or mineral trading in the Democratic Republic of the Congo or an adjoining country. &nbsp;Suppliers to the FIRM must establish and document their adherence to policies, due diligence frameworks and management systems consistent with the <a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><u>OECD (2013), OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas, Second Edition</u>, </a>that are designed to accomplish our mutual goal of buying and selling only DRC conflict-free products and components.</em></p>

<ol style="list-style-type:lower-alpha;">
	<li value="2">Review the firm&rsquo;s draft supplier policy with Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
</ol>

<ol>
	<li value="4">E-mail your firm&rsquo;s final supplier policy to all the personnel identified in Task 4.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that the e-mail message includes a statement that if your supplier has any questions they should contact the firm&rsquo;s conflict minerals spokesperson for clarification.</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Develop conflict minerals reporting policy",
:instructions => <<EOT
<ol>
	<li style="margin-left: 0.25in;">The firm must prepare a written policy regarding the use of Conflict Minerals that it can communicate to employees, customers, suppliers and the public. This policy must be similar to that recommended by the OECD (2013) in <a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas</em></a>.&nbsp; (See Annex II, <em>Model Supply Chain Policy for a Responsible Global Supply Chain of Minerals from Conflict-Affected and High-Risk Areas</em>, page 20.)<br />
	&nbsp;</li>
	<li style="margin-left: 0.25in;">Document approval of the firm&#39;s policy by both the Conflict Minerals Oversight Reporting Committee and the Chief Executive Officer.<br />
	&nbsp;</li>
	<li style="margin-left: 0.25in;">If your firm&#39;s Conlict Mineral policy deviates significantly from the OECD&#39;s, document the reasons why.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Place policy on company website",
:instructions => <<EOT
<ol>
	<li style="margin-left: 0.25in;">Place the firm&#39;s written Conflict Minerals Policy on the firm&#39;s website with the page title Conflict Minerals Disclosure and ensure that it is readily accessible.<br />
	&nbsp;</li>
	<li style="margin-left: 0.25in;">Document&nbsp;a screen shot clearly displaying the URL.<br />
	&nbsp;</li>
	<li style="margin-left: 0.25in;">If the firm&#39;s website has search capability, document that entering the term &quot;Conflict Minerals&quot; returns the link to the firm&#39;s written policy.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Provide internal training on reporting tools",
:instructions => <<EOT
<ol>
	<li>Develop or purchase for the firm Conflict Mineral Rule reporting training materials.</li>
	<li>Review materials and messages with Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
	<li>Conduct in-person internal training session(s) on the Conflict Minerals Rule and the firm&rsquo;s reporting tools for relevant personnel. &nbsp;Document for each training session:
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

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Create FAQs on conflict minerals reporting",
:instructions => <<EOT
<ol>
	<li>Create a proposed list of Frequently Asked Questions (FAQs) and their answers regarding conflict minerals reporting as it applies to your firm.
	<ol style="list-style-type:lower-alpha;">
		<li>Review <a href="http://www.aiag.org/staticcontent/committees/download_files/download.cfm?fname=AIAG_Conflict_Minerals_FAQs_11%2012%2012_with_final_edits.pdf"><em>AIAG Conflict Minerals Frequently Asked Questions</em></a> and <em><a href="http://www.pwc.com/us/en/audit-assurance-services/conflict-minerals-faqs.jhtml">PwC Conflict Minerals: Frequently Asked Questions</a></em> as model FAQ lists that can be modified to take into account your firm&rsquo;s specific circumstances and requirements.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Review your firm&rsquo;s proposed FAQs on conflict minerals reporting with the Conflict Minerals Reporting Oversight Committee and modify as recommended.<br />
	&nbsp;</li>
	<li>In conjunction with the Conflict Minerals Reporting Oversight Committee, decide to whom and how to communicate the firm&rsquo;s FAQs on conflict minerals reporting.
	<ol style="list-style-type:lower-alpha;">
		<li>Firm&rsquo;s should place their FAQs:</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.5in;">i.On their website under the Compliance Minerals Disclosure page for the public;</p>

<p style="margin-left:1.5in;">ii.On their intranet and as part of management training classes for employees;</p>

<p style="margin-left:1.5in;">iii.As an e-mail attachment with the appropriate cover note for upstream suppliers whose conflict minerals contacts have been obtained in Task 4.</p>


EOT
}

tasks << {
:name => "Determine which executive will sign off on final report",
:instructions => <<EOT
<ol>
	<li>Prepare a list of executive <em><u>officers</u></em> who should be considered for signing off on the firm&rsquo;s final conflict minerals reports.&nbsp; Include in this list the firm&rsquo;s CEO, COO, CFO and VP Manufacturing Operations.<br />
	&nbsp;</li>
	<li>Review the list with the Conflict Minerals Reporting Oversight Committee and select the executive officer most knowledgeable about the firm&rsquo;s conflict minerals initiative.<br />
	&nbsp;</li>
	<li>Provide the name, title, department and contact information for the executive officer who will have the responsibility for signing off on final conflict minerals reports.<br />
	&nbsp;</li>
	<li>Describe the reasons this individual is most qualified to sign off on the firm&rsquo;s final conflict minerals reports.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Provide supplier training on reporting process",
:instructions => <<EOT
<ol>
	<li>Prepare a training session explaining your firm&rsquo;s conflict minerals policy, stating information input requirements (Reasonable Country of Origin Inquiry report and Conflict Minerals Due Diligence report) from its upstream suppliers, describing the format these reports must be in and the information included, when and to whom these reports must be provided to your firm, how these reports will be used, and your firm&rsquo;s policy on protecting the confidential information contained in the reports.<br />
	&nbsp;</li>
	<li>Review the proposed supplier training agenda and content on conflict minerals reporting with the Conflict Minerals Reporting Oversight Committee and modify as recommended.<br />
	&nbsp;</li>
	<li>Invite all the suppliers identified in Task 4 to attend the training session in person at your facility.
	<ol style="list-style-type:lower-alpha;">
		<li>Record the training session.</li>
		<li>Document who attended.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Make the supplier training session available to all your firm&rsquo;s suppliers identified in Task 4 and the appropriate internal personnel.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Design and implement a strategy to respond to identified risk",
:instructions => <<EOT
<ol>
	<li>Meet with your strategic customers one-on-one with the objective of identifying risks in your conflict minerals reporting strategy.
	<ol style="list-style-type:lower-alpha;">
		<li>Review your firm&rsquo;s conflict minerals policy, reporting (including upstream supplier reporting requirements) and communications procedures, and key personnel.</li>
		<li>Request similar information from your customers.</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.5in;">i.Note that if a customer cannot provide similar information, this may be the indication of a risk for your firm as your customer may be incurring additional market risk.</p>

<ol style="list-style-type:lower-alpha;">
	<li value="3">Ask your customers to identify potential risks in your conflict minerals reporting program.</li>
	<li value="4">Prepare a Conflict Minerals Market Risk Analysis for your firm based upon these customer interviews.</li>
</ol>

<ol>
	<li value="2">Develop procedures for suspending or terminating suppliers that do not comply with your firm&rsquo;s conflict minerals policy and reporting requirements.
	<ol style="list-style-type:lower-alpha;">
		<li>Identify alternative sources for products/components containing conflict materials and/or conflict minerals.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li value="3">Compare your firm&rsquo;s conflict minerals&rsquo; policy and supplier practices with industry norms to ensure that you are not unreasonably incurring unacceptable market risk.<br />
	&nbsp;</li>
	<li value="4">If risks relating to the Conflict Minerals Rule appear to be significant, prepare a risk factor statement describing the uncertainties and how these uncertainties might negatively impact your firm.<br />
	&nbsp;</li>
	<li value="5">Review the proposed actions above with the Conflict Minerals Reporting Oversight Committee and modify as recommended.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Assess adequate staffing for conflict minerals reporting activities",
:instructions => <<EOT
<ol>
	<li>Consider whether one or more additional internal hires are needed to manage the Conflict Minerals Rule compliance program.<br />
	&nbsp;</li>
	<li>Consider whether the internal team needs to be supplemented by specialist outside counsel. Outside counsel can assist in:
	<ol style="list-style-type:lower-alpha;">
		<li>Developing the compliance program;</li>
		<li>Educating personnel on the requirements of the Conflict Minerals Rule;</li>
		<li>Advising on interpretive questions and gray areas under the rule (there are many);</li>
		<li>Preparing compliance policies, supplier communications, questionnaires, certifications and contract modifications;</li>
		<li>Reviewing and advising on incoming materials from suppliers and customers;</li>
		<li>Preparing Conflict Minerals Rule disclosure.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Consider the need for outside consultants.&nbsp; Consultants can assist in:
	<ol style="list-style-type:lower-alpha;">
		<li>Analyzing the supply chain and supply chain risk;</li>
		<li>Developing and assessing the effectiveness of diligence procedures;</li>
		<li>Advising on and implementing enhancements to IT systems.</li>
	</ol>
	</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Develop internal communication plan",
:instructions => <<EOT
<ol>
	<li>Identify the employees within your firm who should be included in all internal conflict minerals reporting communications.
	<ol style="list-style-type:lower-alpha;">
		<li>Maintain this list in an accessible and secure location.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Send an initial written communication to the appropriate employees informing them about the Conflict Minerals Rule, the firm&rsquo;s compliance obligations under the rule (including key reporting dates), compliance policy, and executives charged with documenting compliance.
	<ol style="list-style-type:lower-alpha;">
		<li>Provide links to the firm&rsquo;s Conflict Minerals Reporting FAQs.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Send subsequent written communications to the appropriate employees every 3 months, or when major conflict mineral events occur, updating them about the status of the firm&rsquo;s conflict minerals reporting program and regulatory requirements.
	<ol style="list-style-type:lower-alpha;">
		<li>For example, provide a link to the recording of the supplier conflict minerals reporting training seminar as soon as it is available.<br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Update the firm&rsquo;s compliance manuals and policies to reflect the Conflict Minerals Rule and the firm&rsquo;s compliance policy.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Add conflict minerals language to terms and conditions",
:instructions => <<EOT
<ol>
	<li>The Firm should include conflicts minerals language to its standard supplier contracts.&nbsp; The firm has many options in adding conflict minerals language to its supplier contracts. &nbsp;The criteria for selecting an approach should be select wording that best meets the requirements of its customers and their downstream customers. &nbsp;Examples of four very different approaches are:
	<ol style="list-style-type:lower-alpha;">
		<li>Very large corporations may require suppliers to sign an overarching Supplier Code of Conduct that describes supplier responsibilities to maintain compliance with Labor and Human Rights, Employee Health and Safety, Environmental Impact, Ethics, and Applicable Laws as well as Conflict Minerals.</li>
		<li>Other contracts require suppliers to agree to maintaining adherence to the customer&rsquo;s supply chain policy, allow for inspection rights, detail supplier disclosure, reporting and cooperation rights, and require similar flow-down clauses of the firm&rsquo;s suppliers&rsquo; suppliers.&nbsp; For example: <em>Suppliers must have a Conflict Minerals policy. Smelter information from Supplier and Supplier&#39;s supply chain must be disclosed and updated using the Conflict Minerals Reporting Template for any tantalum used in, or used in the production of, parts, materials, components and products. &nbsp;When Firm notifies Supplier that there are sufficient Conflict-Free Smelters (CFS) available, any tantalum used in, or used in the production of, parts, materials, components and products must be sourced from a CFS. </em>&nbsp;<em>When </em><em>&ldquo;Conflict-free tantalum</em><em>&rdquo; or </em><em>&ldquo;DRC conflict-free tantalum</em><em>&rdquo; is specified in Firm product or component specifications, Supplier is responsible for gathering reports from its supply chain demonstrating that any tantalum used in, or used in the production of, parts, materials, components and products must be sourced from a Compliant Tantalum Conflict-Free Smelter, listed on the Conflict-Free Smelter (CFS) Program webpage.</em></li>
		<li>Yet another approach is to put in broad standard language that is subject to interpretation, such as: <em>Supplier shall adopt policies and establish systems to procure tantalum, tin, tungsten, or gold from sources that have been verified as conflict free, and provide supporting data to Purchaser on its supply chains for tantalum, tin, tungsten, and/or gold when requested.</em></li>
		<li>For small-to-medium sized manufacturers serving larger manufacturers, a good choice might be: <em>Suppliers who manufacture components, parts, or products containing tin, tantalum, tungsten, and/or gold shall define, implement and communicate to sub-suppliers their own Conflict Mineral Policy, outlining their commitment to responsible sourcing and measures for implementation.&nbsp; Suppliers shall work with sub-suppliers to ensure traceability of these metals at least to the smelter level.&nbsp; Traceability data shall be maintained and recorded for 5 years and provided to the Firm upon request.&nbsp; Once such mechanisms are available, suppliers shall ensure that purchased metals originate from smelters validated by Suppliers as being conflict mineral free.&nbsp; Suppliers are encouraged to support industry efforts to enhance traceability and responsible practices in global minerals supply chains.</em><br />
		&nbsp;</li>
	</ol>
	</li>
	<li>Once a rationale for the conflict minerals wording to be added to supplier contracts has been decided upon and approved by both the Conflict Minerals Reporting Oversight Committee and Purchasing Department, the firm should engage an attorney with experience both in the conflict minerals area and contract law to construct the appropriate wording for inclusion in the firm&rsquo;s supplier contracts.<br />
	&nbsp;</li>
	<li>Ensure that all new supplier contracts include the requirements to support the firm&rsquo;s conflict minerals policy and reporting requirements.</li>
</ol>

<p>&nbsp;</p>


EOT
}

tasks << {
:name => "Establish and publish internal processes and standards/norms",
:instructions => <<EOT
<ol>
	<li>Ensure that the processes the firm is implementing for Establishing Strong Company Management Systems (1.00); Identify and Assess Risk in the Supply Chain (2.00); Design and implement a strategy to respond to identified risk (3.00); Third Party Audit of Smelters/Refiners Due Diligence Practices (4.00); and Report Annually on Supply Chain Due Diligence (5.00) are adequately documented in order that they may be replicated in subsequent years.<br />
	&nbsp;</li>
	<li>When potential improvements in the firm&rsquo;s conflict minerals reporting and due diligence process are identified, bring them to the attention of the Conflict Minerals Reporting Oversight Committee for appropriate action.<br />
	&nbsp;</li>
	<li>Upon the completion of all the internal conflict minerals reporting and due diligence tasks except this one, provide the Conflict Minerals Reporting Oversight Committee with a draft report/manual of the firm&rsquo;s current internal processes and standards/norms for its approval and/or improvements.<br />
	&nbsp;</li>
	<li>When approved, publish as a company document entitled, Firm&rsquo;s Conflict Minerals Reporting and Due Diligence Manual, Date Published.<br />
	&nbsp;</li>
	<li>Ensure that the firm&rsquo;s current Conflict Minerals Reporting and Due Diligence Manual is included in the firm&rsquo;s regulatory and standards library and is a part of the appropriate training courses.<br />
	&nbsp;</li>
	<li>Ensure that the firm&rsquo;s current Conflict Minerals Reporting and Due Diligence Manual is provided to all employees whose job functions require it.</li>
</ol>


EOT
}

tasks << {
:name => "Determine if suppliers will be reporting at company level or part level",
:instructions => <<EOT
<ol>
	<li>The purpose of this task is two-fold: 1) To help you prepare for <em>Review 2.0: Identify and Assess Risk in the Supply Chain</em>; and 2) To identify all the 3TG (tin, tantalum, tungsten, gold) smelters/refineries in your supply chain<em>.</em><br />
	&nbsp;</li>
	<li>Send the upstream suppliers in your firm&rsquo;s database established in Task 4 an email:
	<ol style="list-style-type:lower-alpha;">
		<li>Inform them of the Conflict Minerals reporting tool (i.e. iPoint) your firm has decided to use;</li>
		<li>Inquire if they will be using the same industry-wide supply chain mapping tool your firm has selected and if they will be reporting at the company level or part level.</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.5in;">If not, request that they update your firm as soon as possible on the reporting tool they plan to use and if they plan to provide &nbsp;their Reasonable Country of Origin Inquiry (RCOI) report to you at the company level or part level.</p>

<ol>
	<li value="3">Enter your firm&rsquo;s suppliers&rsquo; responses in the central database.<br />
	&nbsp;</li>
	<li value="4">If any suppliers have not responded within 5 business days, follow up with a phone call.</li>
</ol>


EOT
}


template.tasks = tasks.to_json
template.save!
