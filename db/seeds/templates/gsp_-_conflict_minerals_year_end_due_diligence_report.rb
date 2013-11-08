# encoding: UTF-8
puts "Creating Conflict Minerals Year End Due Diligence Report ...".force_encoding('UTF-8')
template = GspTemplate.create({:agency => Agency.find_by_acronym('GSP'),
                               :full_name => 'Dodd-frank Section 1502',
                               :display_name => 'Conflict Minerals Reporting',
                               :description => '',
                               :regulatory_review_name => 'Conflict Minerals Year End Due Diligence Report',
                               :frequency => 'Annual'.force_encoding('UTF-8'),
                               :objectives => "<p>As mandated by the SEC Conflict Minerals Rule, document the Company&rsquo;s conformance to OECD Due Diligence Guidance for the current reporting period.<br />
<em>The recommended tasks do not constitute legal advice.&nbsp; Users should consult with their attorneys about their specific situation.</em></p>
".force_encoding('UTF-8')
                               })

tasks = []

tasks << {
:name => "Company’s Conflict Minerals Sourcing Policy",
:instructions => <<EOT
<p><strong><em><u>Establish Strong Company Management Systems</u></em></strong></p>

<ol>
	<li value="NaN">Attach your Company&rsquo;s Conflict Minerals Sourcing Policy</li>
	<li>Explain how your company&rsquo;s Conflict Minerals Sourcing Policy incorporates the standards against which due diligence is to be conducted, consistent with the standards set forth in the model supply chain policy in of the <em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas</em>, Annex II, <em>Model Supply Chain Policy for a Responsible Global Supply Chain of Minerals from Conflict-Affected and High-Risk Areas.</em></li>
	<li><em>Describe how your company communicated its Conflict Minerals Sourcing Policy to its suppliers and the public during the reporting year.</em></li>
</ol>

EOT
}

tasks << {
:name => "Company’s Conflict Minerals Management Organization",
:instructions => <<EOT
<p><strong><em><u>Establish Strong Company Management Systems</u></em></strong></p>

<ol>
	<li value="NaN">List the names, titles, department, contact information and roles of executives responsible for conflict minerals reporting and due diligence in your company during the reporting year.</li>
	<li>Describe conflict minerals training provided to employees.</li>
	<li>List consulting firms, law firms and other third-party organizations that your company engaged to provide advice and/or assistance with your company&rsquo;s conflict minerals program; briefly describe the services provided; timeframe of the engagement; and the relationship manager&rsquo;s name and contact information.</li>
	<li>Provide your company&rsquo;s cost to operate its conflict minerals program for the reporting year broken down by line item.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Conflict Minerals Scoping",
:instructions => <<EOT
<p><strong><em><u>Establish Strong Company Management Systems</u></em></strong></p>

<ol>
	<li value="NaN">Describe the procedures your company followed to determine if any of its products contain 3TG and then to identify which products contain which metal(s).</li>
	<li>Highlight the steps your company took to observe the &ldquo;no de minimis&rdquo; rule requiring the inclusion of products that contain even a small amount of 3TGs.</li>
	<li>If your company relied on supplier declarations of the composition of their products, describe the procedures your company undertook to verify that the representations were accurate regarding the absence of conflict minerals.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Supplier Communications",
:instructions => <<EOT
<p><strong><em><u>Establish Strong Company Management Systems</u></em></strong></p>

<ol>
	<li value="NaN">Describe the method your company used to maintain a database of your suppliers of products that contain 3TGs, a summary of the information you maintain on each, and the procedures to ensure this supplier information is current.</li>
	<li>List the conflict minerals communications you have delivered to all your suppliers of components containing 3TG.&nbsp; Such communications could include: a) sending them a letter stating your expectations and requirements for their conflict minerals due diligence policies and RCOI reporting requirements; b) sending them an email directing them to review your company&rsquo;s updated Conflict Minerals Sourcing Policy posted on your website; c) including conflict minerals terms and conditions in your supplier contracts; and d) providing your suppliers with conflict minerals due diligence and RCOI reporting training.</li>
</ol>

<p><br />
&nbsp;</p>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Grievance Mechanism",
:instructions => <<EOT
<p><strong><em><u>Establish Strong Company Management Systems</u></em></strong></p>

<ol>
	<li value="NaN">Describe the mechanism your company has put in place to permit concerned parties to provide 3TG sourcing and product composition information that may contradict your suppliers&rsquo; reports.</li>
	<li>Provide an overview explanation of the procedures your company followed to verify any whistleblower information it received.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Supplier RCOI and Due Diligence Compliance Program Information Collection",
:instructions => <<EOT
<p><strong><em><u>Identify and Assess Risks in the Supply Chain </u></em></strong></p>

<ol>
	<li value="NaN">State your company&rsquo;s policy and rationale for when and in what format you require current RCOI reports, Conflict Minerals Policy and Conflict Minerals Due Diligence reports from your suppliers.</li>
	<li>Document your company&rsquo;s requests to the supplier base for their: a) RCOI using the EICC-GeSI Conflict Minerals Reporting template or an alternative form providing at a minimum the same information, b) Conflict Minerals Policy and c) Conflict Minerals Due Diligence Annual Report.</li>
	<li>Explain how your company initially responds to suppliers who either do not provide you with the requested conflict minerals information or provide it to you in an incorrect format.</li>
	<li>Record the number of suppliers your requested information from and the number and percentage of suppliers who responded appropriately.</li>
</ol>

<p>&nbsp;</p>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Supplier RCOI Due Diligence Review",
:instructions => <<EOT
<p><strong><em><u>Identify and Assess Risks in the Supply Chain </u></em></strong></p>

<ol>
	<li value="NaN">With an objective of tracing all 3TGs incorporated in your products back to the smelter, describe the procedures followed to ensure that each supplier&rsquo;s Conflict Minerals Report was reviewed for completeness, consistency, truthfulness and chain of custody back to the smelter.
	<ul>
		<li value="NaN">Highlight the due diligence process employed to verify that when a supplier states &ldquo;Smelter Not Listed&rdquo; in the EICC-GeSI Standard Smelter Names list and then provides a smelter name and location, the supplier referenced smelter is actually a smelter.</li>
		<li value="NaN">Highlight the due diligence process used to identify &ldquo;red flags&rdquo; in the supplier&rsquo;s supply chain.</li>
	</ul>
	</li>
	<li>State the criteria used to categorize the conflict minerals risk each supplier represents to your company based upon your RCOI review. &nbsp;Typical conflict minerals risk categories would include: a) &ldquo;Compliant,&rdquo; b) &ldquo;High Risk,&rdquo; c) &ldquo;Non-Conforming,&rdquo; or d) &ldquo;Non-Reporting.&rdquo;</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Supplier OECD Due Diligence Guidance Reviews",
:instructions => <<EOT
<p><strong><em><u>Identify and Assess Risks in the Supply Chain </u></em></strong></p>

<ol>
	<li value="NaN">Describe the procedures in place to review each supplier&rsquo;s Conflict Minerals Policy and Conflict Minerals Due Diligence Annual Report for conformance with the <em>OECD Due Diligence Guidance for Responsible Supply Chains of Minerals from Conflict-Affected and High-Risk Areas.</em></li>
	<li><em>State the criteria used to categorize the conflict minerals risk each supplier represents to your company based upon your due diligence review.&nbsp; Typical conflict minerals risk categories would include: a) &ldquo;Compliant,&rdquo; b) &ldquo;High Risk,&rdquo; c) &ldquo;Non-Conforming,&rdquo; or d) &ldquo;Non-Reporting.&rdquo;</em></li>
</ol>

<p><br />
&nbsp;</p>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Preparation of Company’s RCOI and Conflict Minerals Due Diligence Reports",
:instructions => <<EOT
<p><strong><em><u>Identify and Assess Risks in the Supply Chain </u></em></strong></p>

<ol>
	<li value="NaN">State the reasons your company decided to report its Declaration Scope level as: a) Company, b) Division, c) Product Category, or d) Product.</li>
	<li>Describe how the information on your suppliers&rsquo; Conflict Minerals Reports was consolidated to create your company&rsquo;s RCOI reports.&nbsp; Highlight how smelter information was consolidated and checked to determine if smelters had been classified as Conflict Free by an industry auditing group.</li>
	<li>Describe how your suppliers&rsquo; Conflict Mineral Policies and Due Diligence Reports were accounted for in your company&rsquo;s Due Diligence Report over the Source and Chain of Custody of 3TGs sourced in the DRC region</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Communicate actual and potential risks to executive management and the board of directors",
:instructions => <<EOT
<p><strong><em><u>Design and Implement a Strategy to Respond to Identified Risks</u></em></strong></p>

<ol>
	<li value="NaN">Describe the report format and frequency with which your company&rsquo;s conflict minerals compliance manager updated executive management regarding the current and potential risks of funding armed conflict in the DRC through the sourcing of conflict minerals.</li>
	<li>Describe the procedures executive management followed for updating the board of directors regarding actual and potential conflict minerals risks.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "3.Response to “Non-Reporting” and “Non-Conforming” Suppliers ",
:instructions => <<EOT
<p><strong><em><u>Design and Implement a Strategy to Respond to Identified Risks</u></em></strong></p>

<ol>
	<li value="NaN">Describe the company&rsquo;s policy for responding to &ldquo;Non-Reporting&rdquo; and &ldquo;Non-Conforming&rdquo; suppliers.&nbsp; If the policy did not include a plan of action for removing them from current purchases and barring them new opportunities until they demonstrated they were in compliance with your conflict minerals policy, explain why.</li>
	<li>If your company removed any suppliers from its authorized supplier list for failure to meet your conflict minerals requirements during this reporting period, list them.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Response to “High Risk” Suppliers ",
:instructions => <<EOT
<p><strong><em><u>Design and Implement a Strategy to Respond to Identified Risks</u></em></strong></p>

<ol>
	<li value="NaN">Describe the company&rsquo;s policy for communicating to &ldquo;High Risk&rdquo; suppliers the risks the company has identified and what actions the supplier must take, and within what time period, to be Conflict Minerals Compliant.&nbsp; If the policy did not include a plan of action for reclassifying the &ldquo;High Risk&rdquo; supplier as &ldquo;Non-Conforming&rdquo; for not achieving &ldquo;Compliant&rdquo; status within a reasonable time, explain why.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Give preference to suppliers whose 3TGs are sourced from Conflict Free Smelters ",
:instructions => <<EOT
<p><strong><em><u>Third Party Audit of Smelter/Refiner&rsquo;s Due Diligence Practices</u></em></strong></p>

<ol>
	<li value="NaN">Describe the procedures your company employed to maintain a database of Conflict Free Smelters based on independent audits facilitated by the London Bullion Market Association, the Responsible Jewellery Council and the CFSI&rsquo;s Conflict-Free Smelter Program.&nbsp; These audits satisfy the SEC requirement for the &ldquo;source and chain of custody&rdquo; of minerals sourced from the DRC or adjoining countries.</li>
</ol>

<ul style="margin-left: 40px;">
	<li value="NaN">If your company was a member of these associations or contributed to their conflict free smelter initiatives, please document.</li>
</ul>

<ol start="2">
	<li>Describe the procedures your procurement organization had in place to give preference to suppliers whose 3TGs were sourced from the Conflict Free Smelters identified above and documented a conflict free supply chain for the products it supplied your company.</li>
</ol>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Review the adequacy of your company’s annual Conflict Minerals Report",
:instructions => <<EOT
<p><strong><em><u>Report Annually on Supply Chain Due Diligence</u></em></strong></p>

<ol start="1">
	<li>Attach your company&rsquo;s annual Conflict Minerals Report.&nbsp; Review if from the perspective that: a) if your company is a Filer, it must both be made publicly available and included as an exhibit to Form SD; or b) if a Non-Filer, the company should provide it to its customers as a summary of its due diligence procedures and RCOI findings as well as may make publicly available for sales, marketing and governance reasons.</li>
	<li>If your company can state in good faith that all of its 3TGs are &ldquo;Conflict Free,&rdquo; review the Conflict Minerals Report (CMR) from the perspective that it can just be a brief supporting statement. </li>
	<li>If your company states that its 3TGs are &ldquo;DRC Conflict Undeterminable&rdquo; or &ldquo;DRC Not Conflict &nbsp;Free,&rdquo; the CMR should include sections describing:
	<ul>
		<li value="NaN">Due diligence on source and chain of custody;</li>
		<li value="NaN">Ensure that this section includes an accurate summary description of the company&rsquo;s:</li>
		<li value="NaN">Conflict Minerals Sourcing Policy;</li>
		<li value="NaN">Conflict Management Organization;</li>
		<li value="NaN">Conflict Minerals Scoping Procedure;</li>
		<li value="NaN">Supplier Communications;</li>
		<li value="NaN">Grievance Mechanism;</li>
		<li value="NaN">Supplier Due Diligence and RCOI Conflict Minerals Information Collection and Risk Analysis;</li>
		<li value="NaN">Procedure for Preparation of Company Due Diligence and RCOI Reports;</li>
		<li value="NaN">Communications of Actual and Potential Risks to Management;</li>
		<li value="NaN">Response to Non-Reporting, Non-Conforming and High-Risk Suppliers; and</li>
		<li value="NaN">Communications to the report&rsquo;s authors that they are personally liable for false or misleading material statements.</li>
	</ul>
	</li>
	<li>Steps taken/to be taken to mitigate risk 3TGs benefited armed groups.</li>
</ol>

<ul style="margin-left: 40px;">
	<li value="NaN">Ensure that this section includes a summary description of the company&rsquo;s:
	<ul>
		<li value="NaN">Preferential response to suppliers whose 3TGs are sourced from Conflict Free Smelters; and</li>
		<li value="NaN">Policy for potentially classifying as &ldquo;unqualified&rdquo; suppliers where a &ldquo;red flag&rdquo; has been identified in their supply chain.</li>
	</ul>
	</li>
</ul>

<ol start="5">
	<li>Any further steps to improve Due Diligence.</li>
</ol>

<ul style="margin-left: 40px;">
	<li>Ensure that this section at a minimum includes your plans for the next reporting period to:
	<ul>
		<li value="NaN">More closely conform to the OECD Guidance;</li>
		<li value="NaN">Increase the percentage and quality of supplier responses, and</li>
		<li value="NaN">Trace a greater percentage of your 3TGs to smelters with greater confidence.</li>
	</ul>
	</li>
</ul>

<div>
<p><strong><u>Note that the following&nbsp; four&nbsp;instructions need to be completed only if the company knows with certainty that its products contain 3TGs that are &ldquo;DRC Not Conflict Free.&rdquo;</u></strong></p>
</div>

<ol start="6">
	<li>Country of origin in the Covered Countries, if known.
	<ul>
		<li value="NaN">If your company knows that its 3TGs are &ldquo;DRC Not Conflict Free,&rdquo; list the covered countries they came from.</li>
	</ul>
	</li>
	<li>Smelting facilities that processed the 3TGs, if known.
	<ul>
		<li value="NaN">If your company knows that its 3TGs are &ldquo;DRC Not Conflict Free,&rdquo; ensure that it accurately lists the smelters that processed them.</li>
	</ul>
	</li>
	<li>Efforts to determine mine or origin with greatest possible specificity.
	<ul>
		<li value="NaN">If your company knows that its 3TGs are &ldquo;DRC Not Conflict Free&rdquo; and your company purchased 3TGs directly from a smelter, ensure that this report describes the efforts your company undertook to identify the mine(s) that supplied the &ldquo;DRC Not Conflict Free&rdquo; minerals to the smelter.</li>
	</ul>
	</li>
	<li>Products, facilities used to process them.
	<ul>
		<li value="NaN">Ensure that this report includes a description of the company&rsquo;s products that were classified as &ldquo;DRC Not Conflict Free&rdquo; and with each product a listing of the smelter(s) that processed the &ldquo;DRC Not Conflict Free&rdquo; minerals.</li>
	</ul>
	</li>
	<li>Filers-only: Ensure that the company properly documents for this current reporting year why or why not it is subject to an independent audit per Dodd-Frank Section 1502.
	<ul>
		<li value="NaN">If the company must have an independent audit, ensure that the auditor has access to all the information maintained in the Green Status Pro system.</li>
	</ul>
	</li>
</ol>

<p>&nbsp;</p>

<p>&nbsp;</p>

EOT
}

tasks << {
:name => "Filers-only: Ensure that Form SD is accurately completed and submitted to the SEC",
:instructions => <<EOT
<p><strong><em><u>Report Annually on Supply Chain Due Diligence</u></em></strong></p>

<ol start="1">
	<li>Ensure that Form SD has been properly completed, including the addition of the Conflict Minerals Report as an exhibit.</li>
	<li>Ensure that Form SD has been signed by a company officer before being submitted to the SEC.</li>
	<li>Document that Form SD was submitted to the SEC by May&nbsp;31.</li>
	<li>Document that Form SD, including the Conflict Minerals Report, for the current reporting year is posted on the company&rsquo;s web site.</li>
</ol>

EOT
}

tasks << {
:name => "Review the adequacy of the annual conflict minerals situational analysis report for executive management",
:instructions => <<EOT
<p><strong><em><u>Report Annually on Supply Chain Due Diligence</u></em></strong></p>

<ol>
	<li value="NaN">Ensure that the annual conflict minerals situational analysis report accurately portrayed:
	<ul>
		<li value="NaN">A listing of conflict minerals-related risks that the program minimized;</li>
		<li value="NaN">Efficacy and risks inherent in the company&rsquo;s current Conflict Minerals Program;</li>
		<li value="NaN">Staffing and funding requirements for properly maintaining the program;</li>
		<li value="NaN">Metrics used to monitor the effectiveness of the program;</li>
		<li value="NaN">Planned actions to achieve year-over-year improvements.</li>
	</ul>
	</li>
</ol>

EOT
}


template.tasks = tasks.to_json
template.save!
