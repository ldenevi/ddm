# encoding: UTF-8
puts "Creating Conflict Minerals Due Diligence for Auto Industry Manufacturers: Identify and Assess Risk in the Supply Chain ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Conflict Minerals, Dodd-Frank Section 1502',
                               :display_name => 'Conflict Minerals',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Due Diligence for Auto Industry Manufacturers: Identify and Assess Risk in the Supply Chain',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p><strong>Objective:</strong> To identify and assess risks on the circumstances of extraction, trading, handling and export of minerals from conflict-affected and high-risk areas.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Identify suppliers for due diligence based on criteria established",
:instructions => <<EOT
<ol>
	<li>Based on the work effort in the tasks 5 and 7, <em>Determine scope of which products and components are applicable </em>and<em> Develop and distribute supplier communication</em>, in the review, <em>Establish Strong Company Management Systems</em>, create a database of suppliers and the materials, products, components your firm purchases from them that have been identified as containing conflict minerals (tin, tungsten, tantalum or gold).
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that each supplier&rsquo;s corporate headquarters location is clearly identified with subsidiaries and satellite locations distinctly noted.</li>
	</ol>
	</li>
	<li>Ensure that your firm has identified a conflict minerals reporting contact (spokesperson) for each supplier identified above as the outcome of task 4, <em>Create process for supplier questions</em>, in the review, <em>Establish Strong Company Management Systems.</em>
	<ol style="list-style-type:lower-alpha;">
		<li>Unless modified due to the results of this review&rsquo;s task 2, <em>Review supplier identification process</em>, this list of contacts will be the basis for your firm&rsquo;s RCOI (Reasonable Country of Origin Inquiry) work effort.</li>
	</ol>
	</li>
	<li>Concisely and clearly document the process and results of instructions 1 and 2 above in order that they can be summarized for inclusion in the &ldquo;Conflict Minerals Report&rdquo; which will be an exhibit in SEC Form SD, if the firm is a filer; may be audited by an independent firm if the firm is a filer; will be required to be made public on the internet, if the firm is a filer; and may be made public on the internet and/or provided to downstream customers for business policy reasons, if the firm is not a filer.</li>
</ol>

EOT
}

tasks << {
:name => "Review supplier identification process",
:instructions => <<EOT
<ol>
	<li>Identify each supplier using either its unique headquarters location DUNS number or IMDS supplier number.
	<ol style="list-style-type:lower-alpha;">
		<li>Ensure that supplier divisions or satellite locations are not categorized as separate suppliers in your firm&rsquo;s conflict minerals supplier database.</li>
		<li>Ensure that your firm has identified a conflict minerals reporting contact for each supplier identified above as the outcome of task 4, <em>Create process for supplier questions</em>, in the review, <em>Establish Strong Company Management Systems.</em></li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Conduct RCOI to determine whether the conflict minerals originated in the DRC countries",
:instructions => <<EOT
<ol>
	<li>If you buy conflict minerals directly from a smelter or refinery, contact each of your firm&rsquo;s supplier conflict minerals reporting contacts for each smelter/refinery and request: a) if the smelter/refinery has been categorized as a Conflict Free Smelter by the Conflict Free Smelter Program; b) a written declaration as to whether your firm&rsquo;s purchases of conflict minerals have been &ldquo;DRC conflict free,&rdquo; &ldquo;DRC conflict undeterminable,&rdquo; or &ldquo;Not DRC conflict free ,&rdquo; and c) a copy of the smelter/refinery&rsquo;s Conflict Free Policy.&nbsp;
	<ol style="list-style-type:lower-alpha;">
		<li>If the smelter/refinery has been designated as Conflict Free by the CFS Program, request the auditor&rsquo;s report.</li>
		<li>If the smelter/refinery has <strong><em><u>not</u></em></strong> been designated as Conflict Free by the CFS Program, request a written statement signed by an executive officer stating why it has not been designated as conflict free by the CFS Program.</li>
		<li>Document the communication process and response in detail.</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.5in;">i.Person or program office contacted;</p>

<p style="margin-left:1.5in;">ii.Method of communications, i.e. e-mail, phone, in-person meeting, iPoint, etc.;</p>

<p style="margin-left:1.5in;">iii.Date;</p>

<p style="margin-left:1.5in;">iv.Response, including spokesperson, date, and method of communications.</p>

<ol>
	<li value="2">For materials, products and components that your firm purchases that contain conflict minerals, contact each of the supplier&rsquo;s conflict minerals reporting contact and request the supplier&rsquo;s most recent RCOI report in the <a href="http://www.conflictfreesmelter.org/ConflictMineralsReportingTemplateDashboard.htm">EICC-GeSI Conflict Mineral Reporting Template</a> Declaration Statement or iPCMP format.&nbsp; Highlight that your firm&rsquo;s objective is to trace the conflict minerals supply chain back to the smelter/refinery.

	<ol style="list-style-type:lower-alpha;">
		<li>Document the communication process and response in detail.</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.5in;">i.Person or program office contacted;</p>

<p style="margin-left:1.5in;">ii.Method of communications, i.e. e-mail, phone, in-person meeting, iPoint, etc.;</p>

<p style="margin-left:1.5in;">iii.Date;</p>

<p style="margin-left:1.5in;">iv.Response, including spokesperson, date, and method of communications.</p>

<ol>
	<li value="3">Review each supplier&rsquo;s RCOI report (which must be provide in either EiCC/GESI or iPCMP format) and, if the conflict materials originating smelter/refinery was not identified, make a determination if the report was conducted in good faith.&nbsp;
	<ol style="list-style-type:lower-alpha;">
		<li>If you have any questions about a report, contact the supplier&rsquo;s conflict minerals reporting spokesperson, discuss your concerns and document the conversation. &nbsp;If appropriate, follow-up with written correspondence.</li>
	</ol>
	</li>
	<li value="4">Based upon the research above, create your firm&rsquo;s draft RCOI report, including all identified source smelters/refineries, using the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format.&nbsp; (An excellent example of a properly completed RCOI report for 2012 using the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format is <a href="http://www.philips.com/shared/assets/company_profile/downloads/Philips-Conflict-Minerals-Declaration.pdf">Philips Conflict Minerals Declaration</a>.) &nbsp;Guidelines for Questions 1-6 are:</li>
</ol>

<p style="margin-left:1.0in;"><strong>a.</strong><strong>Question 1: Are any of the following metals necessary to the functionality or production of your company</strong><strong>&rsquo;s products that it manufactures or contracts to manufacture?</strong></p>

<p style="margin-left:1.5in;">i.It is expected you will answer Yes to these questions if your product(s) contains any amount (even trace amounts) of the conflict minerals.</p>

<p style="margin-left:1.5in;">ii.If you answer No for any of the derivatives in this question, you must enter the specific reason in the comments section.&nbsp; Examples of specific No reasons:</p>

<ol>
	<li>The firm&rsquo;s products do not contain, in any form, any of the conflict minerals listed;</li>
	<li>The product contains conflict minerals but they are not necessary for its functionality.&nbsp; (Note: this answer requires documentation, such as a statement that the conflict minerals are for used for decorative purposes only.);</li>
	<li>Conflict minerals are used in the production process only and the finished product does not contain any conflict minerals.</li>
</ol>

<p style="margin-left:1.0in;"><strong>b.</strong><strong>Question 2: Do the following metals (necessary to the functionality or production of your company</strong><strong>&rsquo;s products) originate from the DRC or adjoining countries?</strong></p>

<p style="margin-left:1.5in;">i.If your firms products contain conflict minerals and you can answer No, your firm must provide the names and locations of the smelters/refineries from which the conflict minerals were sourced. &nbsp;</p>

<p style="margin-left:1.5in;">ii.If your products contain conflict minerals but you cannot provide smelter/refinery-level information, you must answer uncertain or unknown.</p>

<p style="margin-left:1.5in;">iii.If your products contain conflict minerals and you know they originate from the DRC or adjoining countries, you must answer, Yes.</p>

<p style="margin-left:1.0in;"><strong>c.</strong><strong>Question 3: Do the following metals (necessary to the functionality or production of your company</strong><strong>&rsquo;s products) come from a recycler or scrap supplier?</strong></p>

<p style="margin-left:1.5in;">i.If your firm answers Yes, you must be able to provide proof these conflict minerals come from recycled or scrap sources. &nbsp;A brief description to support your Yes answer must be provided.</p>

<p style="margin-left:1.0in;"><strong>d.</strong><strong>Question 4: Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?</strong></p>

<p style="margin-left:1.5in;">i.Provide the percentage of your firms suppliers that you contacted and the percentage that responded.&nbsp;&nbsp; For example: The firm contacted 100% of its suppliers of components that contain conflict minerals and received responses from 80% of those contacted.</p>

<p style="margin-left:1.0in;"><strong>e.</strong><strong>Question 5: For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope above?</strong></p>

<p style="margin-left:1.5in;">i.If your firm answers Yes, you must list the names of the smelters for each metal in the Smelter List worksheet or in the iPCMP tool. &nbsp;Complete mine and smelter location addresses must be provided for any smelter that is not listed in the dropdown menus.</p>

<p style="margin-left:1.0in;"><strong>f.</strong><strong>Question 6: Have all of the smelters used by your company and its suppliers been validated as compliant in accordance with the Conflict-Free Smelter Program and listed on the Compliance Smelter List for the following metals?</strong></p>

<p style="margin-left:1.5in;">i.If your firm answers Yes, list the names of the smelters for each metal in the Smelter List worksheet or in the iPCMP tool.</p>

<p style="margin-left:1.0in;"><strong>g.</strong><strong>Answer the following Questions at a Company level</strong></p>

<p style="margin-left:1.5in;">i.Provide an explanation expanding upon any No answer for questions A-J.&nbsp; If possible, for Yes answers provide links to supporting materials, such as the firms Conflict Minerals Policy.</p>

<ol>
	<li value="5">Review the draft RCOI report with the Conflict Minerals Reporting Oversight Committee and make modifications as recommended.</li>
	<li value="6">Publish your RCOI report in both the EICC-GeSI Conflict Mineral Reporting Template Declaration Statement format, and, if you licensed iPCMP from iPoint, the iPCMP format.</li>
	<li value="7">Concisely and clearly document the process and results of your work efforts in order that they can be summarized for inclusion in the &ldquo;Conflict Minerals Report&rdquo; which will be an exhibit in SEC Form SD, if the firm is a filer; may be audited by an independent firm, if the firm is a filer; will be required to be made public on the internet, if the firm is a filer; and may be made public on the internet and/or provided to downstream customers for business policy reasons, if the firm is not a filer.</li>
</ol>

EOT
}

tasks << {
:name => "Disclose description of RCOI and results in new Form SD",
:instructions => <<EOT
<ol>
	<li>Document if your firm will disclose a description of RCOI and results in SEC Form SD.&nbsp; If not, explain why not.
	<ol style="list-style-type:lower-alpha;">
		<li>SEC filers are required to complete and file Form SD with the SEC by May 31 for the previous calendar year.&nbsp; Non-filers who are manufacturers of materials, products, components containing conflict minerals are not required to complete or file Form SD.&nbsp; However, best business practices dictate that non-filers should complete Form SD and make it available to their customers in order to remove themselves as a potential risk in their customers&rsquo; supply chain due diligence review.&nbsp;</li>
	</ol>
	</li>
	<li>If your firm is a filer, engage counsel to assist in completing and filing Form SD as there are transition period reporting exclusions that should be taken into consideration and a requirement for a due diligence audit if your firm has identified that it uses materials, products, or components that contain conflict minerals that originate from the DRC or adjoining countries or, after the transition period, are &ldquo;Conflict free undeterminable.&rdquo;</li>
	<li>If the conclusion of the RCOI was that the firm&rsquo;s conflict minerals did <strong><em><u>not</u></em></strong> come from the DRC or adjoining countries, it is still required to include in Form SD:
	<ol style="list-style-type:lower-alpha;">
		<li>A heading entitled &ldquo;Conflict Minerals Disclosure.&rdquo;&nbsp; The first section should be a disclosure of how the firm came to the conclusion that it did not use conflict minerals sourced from the DRC or adjoining countries.&nbsp;</li>
		<li>Briefly describe the RCOI process the firm undertook in making this determination and the results of the inquiry it performed.</li>
		<li>Finally, the firm must disclose this information on its publicly available Internet website and, under a separate heading in its specialized disclosure report entitled, &ldquo;Conflict Minerals Disclosure,&rdquo; provide a link to that website.</li>
	</ol>
	</li>
	<li>If the conclusion of the RCOI was that the firm&rsquo;s conflict minerals did come from the DRC and/or adjoining countries, a firm is required:
	<ol style="list-style-type:lower-alpha;">
		<li>To include this conclusion in Form SD and briefly describe the RCOI it undertook in making this determination and the results of the inquiry it performed.</li>
		<li>The firm must disclose this information on its publicly available Internet website and, under a separate heading in its specialized disclosure report entitled &ldquo;Conflict Minerals Disclosure,&rdquo; provide a link to that website.</li>
		<li>In addition the filer must include in Form SD and publish on its Internet website a report entitled, <em>Conflict Minerals Report</em>, which includes the following information:</li>
	</ol>
	</li>
</ol>

<p style="margin-left:1.0in;"><strong><em>Due Diligence</em></strong>: A description of the measures the firm has taken to exercise due diligence on the source and chain of custody of those conflict minerals.&nbsp; (Refer to SEC Form SD for an in-depth description of Due Diligence.);</p>

<ul style="margin-left: 80px;">
	<li>An independent private sector audit of the firm&rsquo;s Due Diligence to ensure that it is in conformity with the criteria described by the OECD and that the firm&rsquo;s description of the due diligence process it undertook is accurate.
	<ul>
		<li>Note that if a filer claims its products are &ldquo;DRC conflict undeterminable,&rdquo; a temporary designation, it is not required to obtain an independent private sector audit.</li>
		<li>Unless required by its customers, non-filers should not obtain an independent audit.</li>
	</ul>
	</li>
</ul>

<p style="margin-left:1.0in;"><strong><em>Product Description</em></strong>: For all the firm&rsquo;s product that have <strong><em><u>not</u></em></strong> been found to be &ldquo;DRC conflict free&rdquo; or are temporarily categorized as &ldquo;DRC conflict undeterminable,&rdquo; the firm must:</p>

<ul style="margin-left: 80px;">
	<li>Provide a description of the products;</li>
	<li>Identify the facilities used to process the necessary conflict minerals in those products, if known;</li>
	<li>The country of origin of the necessary conflict minerals in those products, if known;</li>
	<li>The firm&rsquo;s efforts to determine the mine or location of origin with the greatest possible specificity.</li>
</ul>

<ol>
	<li value="5">Review the draft of the Conflict Minerals Disclosure and Conflict Minerals Report with the Conflict Minerals Reporting Oversight Committee and make modifications as recommended before publishing.</li>
</ol>

EOT
}

tasks << {
:name => "Identify resources to complete inquiry/analyze data",
:instructions => <<EOT
<ol>
	<li>If a filer, consult with an attorney or regulatory consultant specializing in the Conflict Minerals Act to review your firm&rsquo;s efforts in Tasks 3 and 4 above for correctness based upon current reporting requirements.
	<ol style="list-style-type:lower-alpha;">
		<li>Request recommendations to improve the process or modify it as required for the upcoming year&rsquo;s reporting requirements.</li>
	</ol>
	</li>
	<li>If a non-filer, review your work efforts in a meeting with a sampling of your strategic customers.
	<ol style="list-style-type:lower-alpha;">
		<li>Request recommendations for improving your firm&rsquo;s reporting process for both the current and upcoming year.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Identify manual process if supplier does not use reporting tool",
:instructions => <<EOT
<ol>
	<li>Document the manual reporting processes used in task 3 for your firm&rsquo;s suppliers who did not use a reporting tool such as IPoint&rsquo;s iPCMP.</li>
	<li>Propose a standard, consistent manual reporting procedure for all suppliers that do not use a reporting tool.</li>
	<li>Review the proposed manual reporting procedure with the Conflict Minerals Reporting Oversight Committee and make modifications as recommended.</li>
	<li>Prepare and communicate a memo for your suppliers insisting they all follow your firm&rsquo;s manual reporting procedure for the next reporting cycle, if they do not adopt iPoint&rsquo;s iPCMP for reporting.</li>
</ol>

EOT
}

tasks << {
:name => "Conduct due diligence on the source and chain of custody of the conflict minerals using a recognized due diligence framework (OECD)",
:instructions => <<EOT
<ol>
	<li>Require that all your suppliers whose materials, products or component contain conflict minerals provide you with their Due Diligence Report based on the OECD (2013) report <a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf"><em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas</em></a><em><a href="http://www.oecd.org/daf/inv/mne/GuidanceEdition2.pdf">,</a> Second Edition</em>. &nbsp;</li>
	<li>Review each supplier&rsquo;s Due Diligence Report to ensure that it is consistent with the OECD&rsquo;s five-step due diligence framework as modified by the AIAG for the auto industry that includes:
	<ol style="list-style-type:lower-alpha;">
		<li>Establish strong management systems</li>
		<li>Identify and assess risk in the supply chain</li>
		<li>Design and implement a strategy to respond to identified risks</li>
		<li>Third-party audit of smelters/refiners due diligence practices</li>
		<li>Report annually on supply chain due diligence</li>
	</ol>
	</li>
	<li>List all risks in the supply chain created by deficiencies in your suppliers&rsquo; due diligence. (Note that the OECD defines <em>due diligence</em> as &ldquo;an on-going, proactive and reactive process through which companies can ensure that they respect human rights and do not contribute to conflict.&rdquo;)</li>
	<li>Review the identified risks with the Conflict Minerals Reporting Oversight Committee.
	<ol style="list-style-type:lower-alpha;">
		<li>The objective should be to determine whether identified supplier risks can be mitigated by continuing with the supplier committing to making the appropriate changes in its due diligence process, suspending or terminating the relationship.</li>
		<li>All the firm&rsquo;s suppliers&rsquo; due diligence processes must have the objective of ensuring that all conflict minerals can be traced back to Conflict Free Smelters as reported at <a href="http://www.conflictfreesmelter.org/">www.conflictfreesmelter.org</a>.</li>
	</ol>
	</li>
	<li>Communicate the identified supplier due diligence risks and proposed firm responses to senior management.</li>
</ol>

EOT
}

tasks << {
:name => "Respond to information requests from customers",
:instructions => <<EOT
<ol>
	<li>Proactively email your firm&rsquo;s completed EICC-GESI Conflict Minerals Reporting Declaration Statement and Due Diligence Report to your firm&rsquo;s customers.</li>
	<li>Provide your firm&rsquo;s completed EICC-GESI Conflict Minerals Reporting Declaration as link in the &ldquo;Conflict Minerals Disclosure&rdquo; page on your firm&rsquo;s website.</li>
	<li>Maintain a log of customer inquiries (Customer Inquiry Log) addressed to the firm&rsquo;s conflict minerals reporting spokesperson.
	<ol style="list-style-type:lower-alpha;">
		<li>Include contact information for the customer&rsquo;s representative making the inquiry, date of the inquiry, your firm&rsquo;s spokesperson, a description of the response provide to the customer, an evaluation of the customer&rsquo;s satisfaction with the answer, if follow-up was required, and when the inquiry was closed.</li>
		<li>Ensure that all customer inquiries are responded to within 2 working days.</li>
		<li>Review the Customer Inquiry log with the Conflict Minerals Oversight Reporting Committee at each scheduled meeting.</li>
		<li>Review in depth any customer inquiries that remained open for more than five business days.</li>
	</ol>
	</li>
</ol>

EOT
}

tasks << {
:name => "Analyze RCOI data for inconsistency",
:instructions => <<EOT
<ol>
	<li>Starting with the supplier your firm purchases the greatest dollar amount of&nbsp; materials, products and/or components that contain conflict minerals and working in descending order, analyze the following:
	<ol style="list-style-type:lower-alpha;">
		<li>Compare the supplier&rsquo;s supply chain policy to the <em>OECD Due Diligence Guidance for Responsible Supply Chains, Annex II, Model Supply Chain Policy for a Responsible Global Supply Chain of Minerals from Conflict-Affected and High-Risk Areas</em> and determine if the supplier&rsquo;s policy is similar.&nbsp;</li>
	</ol>
	</li>
</ol>

<ul>
	<li>If it is not, identify and document the areas in which the policies differ.
	<ul>
		<li style="list-style-type:circle;">Contact the supplier&rsquo;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.</li>
		<li style="list-style-type:circle;">If the inconsistency could indicate a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
		<li style="list-style-type:lower-alpha;" value="2">Compare the supplier&rsquo;s due diligence standards and processes with those recommended by the OECD determine if the supplier&rsquo;s standards and processes are similar.&nbsp;</li>
	</ul>
	</li>
</ul>

<ul>
	<li>If not, identify and document the areas in which the standards and processes differ.
	<ul style="list-style-type:circle;">
		<li>Contact the supplier&rsquo;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.</li>
		<li>If the inconsistency indicates a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
	</ul>
	</li>
</ul>

<ol>
	<li value="2">Identify situations in which multiple suppliers are providing your firm with the same component.
	<ol style="list-style-type:lower-alpha;">
		<li>Test to determine if the component&rsquo;s conflict minerals are mapped back to the same smelter/refinery.
		<ul>
			<li>If they are not, contact each supplier&#39;s conflict minerals reporting spokesperson, review the inconsistency and document the supplier&rsquo;s response.</li>
			<li>If the inconsistency indicates a risk, report it to the Conflict Minerals Reporting Oversight Committee for monitoring.</li>
		</ul>
		</li>
	</ol>
	</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!
