Minthy = "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b"

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    BugChecks()
end)

function BugChecks()
    if Osi.CanFight(Minthy) == 0 or Osi.CanJoinCombat(Minthy) == 0 then
        BugfixCombat()
    end
    if Osi.GetFlag("NIGHT_GoblinHunt_TieflingCelebration_1ad8c357-2695-4d5c-b5f9-8b8c07803121", GetHostCharacter()) == 1
    and Osi.DB_OriginRecruitmentDialog:Get(Minthy, "CAMP_Minthara_e776dff2-6285-3f23-ceff-f40371236993") == nil then
        BugfixDialog()
    end
end

function BugfixCombat()
    Osi.SetCanFight(Minthy, 1)
    Osi.SetCanJoinCombat(Minthy, 1)
    _P("Patching Minthara GodMode")
end

function BugfixDialog()
    Osi.PROC_RemoveAllDialogEntriesForSpeaker(Minthy)
    Osi.DB_Dialogs(Minthy, "CAMP_GoblinHuntCelebration_Drow_9ecb7dd8-4f2f-e641-04d8-29b8482d05ab")
    _P("Patching Minthara Dialog Stuck")
end

function MessageBox(message)
    Osi.OpenMessageBox(Osi.GetHostCharacter(), message)
end


function SetApproval(char, appr)
    Osi.ChangeApprovalRating(Minthy, char, 0, appr)
end

function TieflingPartyRomance()
    Osi.PROC_RemoveAllDialogEntriesForSpeaker(Minthy)
    Osi.DB_Dialogs(Minthy, "CAMP_GoblinHuntCelebration_Drow_9ecb7dd8-4f2f-e641-04d8-29b8482d05ab")
end

function ResetDialog()
    Osi.PROC_RemoveAllDialogEntriesForSpeaker(Minthy)
    Osi.PROC_GLO_Origins_SetRecruitmentDialog(Minthy, "CAMP_Minthara_e776dff2-6285-3f23-ceff-f40371236993")
end

function PatchCheck()
    if Osi.QRY_BG3_SaveGameIsOlderThan("Release Patch 1") == true then
       MessageBox("Game is older than Patch 1. This mod will break things. Please update to at least Patch 1, load your game, save it, and reload again.")
       return true
    end
end

function ResetDialog()
    Osi.DB_OriginNPCAlignment(Minthy, "GLO_DrowCommander_f984f683-e819-439e-af7c-48906053c20b")
    Osi.DB_OriginCampFlags(Minthy, "MINTHARA_0b31064e-d6bb-4f1a-8f76-93a6d33f6520", "NULL_00000000-0000-0000-0000-000000000000", "MINTHARACOMPANION_01ce6386-6b60-4ad1-ba9a-1e7d23b5df1a", "MINTHARAPARTY_032b3a63-5799-4ca8-99a8-bf7bb5034d53", "MINTHARACAMP_1cf98396-5542-42fc-8007-7338d18edec0")
    Osi.DB_OriginInPartyGlobal(Minthy, "ORI_Minthara_State_IsInParty_766b8981-eb17-3ec5-5d30-2626509c550f")
    Osi.DB_OriginPartOfTheTeamFlag(Minthy, "GLO_Origin_PartOfTheTeam_Minthara_fa0e4e0b-08f9-4094-bfed-5205481c683c", "GLO_Origin_Avatar_Minthara_df3686a2-97b1-428d-9c03-0e20c748b650", "ORI_Minthara_ControlledByUser_dba84de8-1dc2-4a76-b1b3-0192399e3b4d")
    Osi.DB_OriginKickFromPartyFlags(Minthy, "ORI_Minthara_Event_KickCompanion_19e6dc5f-14cc-43cf-95bf-291313cc2cfc", "ORI_Minthara_State_CanBeKicked_304f3837-09db-4c62-aed1-ff09cd566c8e")
    Osi.DB_OriginRecruitmentDialog(Minthy, "CAMP_Minthara_e776dff2-6285-3f23-ceff-f40371236993")
    Osi.DB_OriginInPartyDialog(Minthy, "Minthara_InParty_13d72d55-0d47-c280-9e9c-da076d8876d8")
    Osi.DB_OriginWarning1Dialog(Minthy, "Minthara_Warning1_879a678a-1986-2ccc-30f9-9b1057641ae4")
    Osi.DB_OriginWarning2Dialog(Minthy, "Minthara_Warning2_879a678a-1986-2ccc-30f9-9b1057641ae4")
    Osi.DB_OriginLeavingDialog(Minthy, "Minthara_Leaving_0ffad71c-21b5-ed13-cf3a-5d5d0323b927")
    Osi.DB_Inclusion_Object(Minthy, "SCE_Minthara_Inclusion_Start_82541346-7f03-4e80-a590-79ebf95d2332", "SCE_Minthara_Inclusion_End_057432e2-c0cb-4d2d-b16c-157a1e258bf5")
    Osi.DB_Debug_CharacterAddFlags("Debug_AddMinthara_f5989c01-2600-4b16-9f29-c1fc7ee6bb9c", Minthy, "Debug_MintharaIsPlayer_27598901-3ded-41e4-8be0-5b8d88920df4")
    Osi.DB_Debug_CharacterRemoveHideFlags("(Debug_RemoveHideMinthara_9874d577-c50b-4357-bdaf-ec7b49959e00", Minthy)
    Osi.DB_Dialogs(Minthy, "Minthara_InParty_13d72d55-0d47-c280-9e9c-da076d8876d8")
end

function SummonMinthara(char)
    Osi.DB_KnockedOut_RestoreProperties(Minthy, 1, 1, 0)
    Osi.DB_PermaDefeated:Delete(Minthy)
    Osi.DB_PreventPermaDefeated(Minthy)
    Osi.RemoveStatus(Minthy, "KNOCKED_OUT")
    Osi.RemoveHarmfulStatuses(Minthy)
    Osi.SetHitpointsPercentage(Minthy, 100)
    Osi.DB_GOB_BattleStations_CombatGroupCharacters:Delete(Minthy,nil,nil)
    Osi.Resurrect(Minthy)
    Osi.DB_Dead:Delete(Minthy)
    Osi.DB_PermaDefeated:Delete(Minthy)
    Osi.PROC_DebugBook_RecruitCompanion(Minthy, char)
    Osi.FlagSet("DEN_GroveConflict_Knows_LeaderNameDrow_20f20de4-4f03-b2b9-6a6b-e96f5e190160", char, 1)
    Osi.SetFlag("GOB_DrowCommander_Knows_DrowLeader_74279f61-c499-340a-ef38-d26816725bd9", char)
end
--Listeners--


Ext.Osiris.RegisterListener("CastSpell", 5, "after", function (char, spell, nil1, nil2, nil3)
    if spell == "Shout_Summon_Daughter_of_Lolth" then
        if Osi.GetFlag("GEN_MaxPlayerCountReached_823b5064-8aa4-c0b7-1b8c-657b46987ccd", GetHostCharacter()) == 1 and not next(Osi.DB_PartOfTheTeam:Get(Minthy)) then
            MessageBox("Lolth demands space in your party to summon her daughter")
        else
            SummonMinthara(char)
        end
    end
    if spell == "Shout_Influence_Daughter_of_Lolth" then
        SetApproval(char ,50)
    end
    if spell == "Shout_Reset_Daughter_of_Lolth" then
        ResetDialog()
    end
end)

Ext.Osiris.RegisterListener("DB_Camp_QueuedNight", 1, "before", function (campnight)
    if campnight == "NIGHT_GoblinHunt_TieflingCelebration_1ad8c357-2695-4d5c-b5f9-8b8c07803121" then
        Osi.PROC_RemoveAllDialogEntriesForSpeaker(Minthy)
        Osi.DB_Dialogs(Minthy, "CAMP_GoblinHuntCelebration_Drow_9ecb7dd8-4f2f-e641-04d8-29b8482d05ab")
    end
end)

Ext.Osiris.RegisterListener("DB_PermaDefeated", 1, "after", function (ded)
    local priest = "S_GOB_GoblinPriest_b983c336-9a14-4e9b-adb9-4689e7e0afa9"
    local king = "S_GOB_GoblinKing_11337af0-6a57-426b-a820-c4b00923dd54"
    if ded == king or priest then
        if next(Osi.DB_PermaDefeated:Get(king)) and next(Osi.DB_PermaDefeated:Get(priest)) and next(Osi.DB_PartOfTheTeam:Get(Minthy)) then
            Osi.PROC_StateSet_Defeated(Minthy)
            Osi.QuestUpdate(GetHostCharacter(), "DEN_Conflict", "GOB_Trio_KilledDrow")
            Osi.PROC_GLO_DefeatCounter_AllDefeated("GOB_GoblinHunt_Leaders")
        end
    end
end)

Ext.Osiris.RegisterListener("PROC_CampNight_ForceComplete", 1, "after", function (campnight)
    if campnight == "NIGHT_GoblinHunt_TieflingCelebration_1ad8c357-2695-4d5c-b5f9-8b8c07803121" then
        Osi.PROC_RemoveAllDialogEntriesForSpeaker(Minthy)
        Osi.PROC_GLO_Origins_SetRecruitmentDialog(Minthy, "CAMP_Minthara_e776dff2-6285-3f23-ceff-f40371236993")
    end
end)

Ext.Osiris.RegisterListener("DB_SelectedDialog", 7, "before", function (sp1, sp2, sp3, sp4, sp5, sp6, sp7)
    local spk1 = "MOO_Execution_2b2f9929-86da-50b1-c796-7d3e485ed901"
    local spk2 = "S_MOO_Execution_Drow_8e75eb3b-7551-485e-8f98-2bf2e51d3e84"
    local spk3 = "S_MOO_Ketheric_e9918f3e-5b87-40a3-a9bd-61545151573f"
        if sp1 == spk1 and sp2 == spk2 and sp3 == spk3 then
            Osi.TeleportToPosition(Minthy, -152.7500, -171.7500, 21.4033, "", 0, 0, 0)
        end
end)

Ext.Osiris.RegisterListener("SetFlag", 2, "after", function (flag, player)
    if flag == "DEN_CapturedGoblin_State_PlayerRescuedGoblin_2030e459-3a80-1172-8bbd-1d90395deace" and Osi.DB_PartOfTheTeam:Get(Minthy) == Minthy then
        Osi.SetFlag("GOB_CapturedGoblin_Event_Resolved_aae95a8b-bbec-e7c6-f47a-53834c294a2b", GetHostCharacter())
    end
end)

Ext.Osiris.RegisterListener("PROC_SceneOver", 1, "after", function (scene)
    if scene == "MOO_Execution" then
        local x, y, z = Osi.GetPosition(Osi.GetHostCharacter())
        Osi.TeleportToPosition(Minthy, x, y, z, "", 0, 0, 0)
    end
end)

Ext.Osiris.RegisterListener("DB_BUGFIX_Marker", 1, "after", function (bugfix)
    if bugfix == "GUS-303341" then
        _P("Halsin Bugfix Applied. Halsin was taken by Jergel")
    end
end)

Ext.Osiris.RegisterListener("PROC_ApplySavegamePatches", 0, "before", function ()
    if PatchCheck() == true then
        Osi.DB_PartOfTheTeam:Delete(Minthy)
    end
end)

Ext.Osiris.RegisterListener("PROC_ApplySavegamePatches", 0, "after", function ()
    if PatchCheck() == true then
        Osi.DB_PartOfTheTeam(Minthy)
    end
end)