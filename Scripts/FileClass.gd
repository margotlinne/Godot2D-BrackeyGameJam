class Files:
	var name : String
	var inBin : bool
	var parent : String
	var isFolder : bool


	func _init(name: String, inBin: bool, parent: String, isFolder: bool):
		self.name = name
		self.inBin = inBin
		self.parent = parent
		self.isFolder = isFolder
			

var file:=[		
	Files.new("Designs", false, "none", true),	
	
	Files.new("Graphic", false, "Designs", true),
	
	Files.new("company_logo.ai", false, "Graphic", false),
	Files.new("main_banner_2024.png", false, "Graphic", false),
	Files.new("event_flyer.psd", false, "Graphic", false),
	Files.new("app_icon.svg", false, "Graphic", false),
	Files.new("product_brochure_2024.pdf", false, "Graphic", false),
	
	
	Files.new("Web", false, "Designs", true),
	
	Files.new("homepage_v1.html", false, "Web", false),
	Files.new("style_main.css", false, "Web", false),
	Files.new("app_script.js", false, "Web", false),
	Files.new("hero_image_2024.jpg", false, "Web", false),
	Files.new("favicon_website.ico", false, "Web", false),
	
	
	Files.new("Print", false, "Designs", true),
	
	Files.new("business_card_design.ai", false, "Print", false),
	Files.new("official_letterhead_2024.pdf", false, "Print", false),
	Files.new("envelope_design.psd", false, "Print", false),
	Files.new("marketing_poster.png", false, "Print", false),
	Files.new("company_catalog_2024.pdf", false, "Print", false),
	Files.new("invoice_template_2024.docx", false, "Print", false),
	
	#################################################################
	Files.new("Development", false, "none", true),
	
	
	Files.new("Frontend", false, "Development", true),
	
	Files.new("index_v1.html", false, "Frontend", false),
	Files.new("main_styles.css", false, "Frontend", false),
	Files.new("app_core.js", false, "Frontend", false),
	Files.new("landing_page.html", false, "Frontend", false),
	
	
	Files.new("Backend", false, "Development", true),
	
	Files.new("main_server.js", false, "Backend", false),
	Files.new("user_database_schema.sql", false, "Backend", false),
	Files.new("authentication_module.js", false, "Backend", false),
	Files.new("config_file.yaml", false, "Backend", false),
	Files.new("deploy_script.sh", false, "Backend", false),
	Files.new("backup_script.sh", false, "Backend", false),
	
	#################################################################
	Files.new("Projects", false, "none", true),
	
	
	Files.new("Project_Nova", false, "Projects", true),
	
	Files.new("Nova_proposal.docx", false, "Project_Nova", false),
	Files.new("Nova_timeline.xlsx", false, "Project_Nova", false),
	Files.new("Nova_design_sepc.ai", false, "Project_Nova", false),
	Files.new("Nova_budget_summary.xlsx", false, "Project_Nova", false),
	Files.new("Nova_final_report.pdf", false, "Project_Nova", false),
	
	
	Files.new("Project_Horizon", false, "Projects", true),
	
	Files.new("Horizon_proposal.docx", false, "Project_Horizon", false),
	Files.new("Horizon_timeline.xlsx", false, "Project_Horizon", false),
	Files.new("Horizon_design_sepc.ai", false, "Project_Horizon", false),
	Files.new("Horizon_budget_summary.xlsx", false, "Project_Horizon", false),
	Files.new("Horizon_final_report.pdf", false, "Project_Horizon", false),
	
	
	Files.new("Project_Unnamed", false, "Projects", true),
	
	Files.new("Unnamed_proposal.docx", false, "Project_Unnamed", false),
	Files.new("Unnamed_timeline.xlsx", false, "Project_Unnamed", false),
	Files.new("Unnamed_design_sepc.ai", false, "Project_Unnamed", false),
	Files.new("Unnamed_budget_summary.xlsx", false, "Project_Unnamed", false),
	Files.new("Unnamed_final_report.pdf", false, "Project_Unnamed", false),
	
	#################################################################
	Files.new("Marketing", false, "none", true),
	
	
	Files.new("Campaigns", false, "Marketing", true),
	
	Files.new("spring_campaign_2024.pdf", false, "Campaigns", false),
	Files.new("summer_campaign_2024.pdf", false, "Campaigns", false),
	Files.new("fall_campaign_2024.pdf", false, "Campaigns", false),
	Files.new("winter_campaign_2024.pdf", false, "Campaigns", false),
	Files.new("campaign_assets_2024.file", false, "Campaigns", false),

	
	Files.new("SocialMedia", false, "Marketing", true),
	
	Files.new("twitty_strategy_2024.docx", false, "SocialMedia", false),
	Files.new("facekook_campaign_report_2024.docx", false, "SocialMedia", false),
	Files.new("ingstagram_engagement_report_2024.docx", false, "SocialMedia", false),
	Files.new("linkedout_ad_performance_2024.docx", false, "SocialMedia", false),
	Files.new("social_media_content_calendar_2024.xlsx", false, "SocialMedia", false),
	Files.new("content_plan_2024.docx", false, "SocialMedia", false),
	Files.new("ad_spend_summary_2024.xlsx", false, "SocialMedia", false),
	Files.new("post_metrics_2024.docx", false, "SocialMedia", false),
	Files.new("community_growth_report_2024.docx", false, "SocialMedia", false)
]
