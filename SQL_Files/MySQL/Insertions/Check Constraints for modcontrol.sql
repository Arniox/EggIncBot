ModLevel_Id!=(0) AND 
	(
		(ModLevel_Id=(1) AND Stats_Update_Max_Diff IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR
		(ModLevel_Id=(2) AND Stats_Trusted_Role IS NOT NULL AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR
		(ModLevel_Id=(3) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL) OR
		(ModLevel_Id=(4) AND Mod_Approval_Chat IS NOT NULL AND Moderator_Role IS NOT NULL)
	) OR
ModLevel_Id=(0)