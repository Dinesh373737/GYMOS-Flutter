from pathlib import Path
root=Path(r'C:/Users/dines/OneDrive/gym-flutter/gymos2/gymos2_server/lib/src/models')
root.mkdir(parents=True,exist_ok=True)
models={
'Society':('society','name: String\naddressLabel: String\ninviteCode: String\ncreatedBy: String\ncreatedAt: DateTime\nisActive: bool'),
'UserProfile':('user_profile','authUserId: String\ndisplayName: String\nrole: String\nsocietyId: int, relation(parent=society)\nexperienceLevel: String\nprimaryGoal: String\npreferredWorkoutDuration: int\nonboardingComplete: bool\ncreatedAt: DateTime\nupdatedAt: DateTime'),
'SocietyMembership':('society_membership','societyId: int, relation(parent=society)\nuserId: int, relation(parent=user_profile)\nrole: String\njoinedAt: DateTime\nisActive: bool'),
'Exercise':('exercise','name: String\nslug: String\ninstructions: String\ndifficulty: String\nmovementPattern: String\nexerciseType: String\ndefaultDurationMin: int\nisActive: bool'),
'MuscleGroup':('muscle_group','name: String\nbodyArea: String'),
'ExerciseMuscle':('exercise_muscle','exerciseId: int, relation(parent=exercise)\nmuscleGroupId: int, relation(parent=muscle_group)\ncontribution: double'),
'EquipmentCatalog':('equipment_catalog','name: String\ncategory: String\ndescription: String'),
'ExerciseEquipment':('exercise_equipment','exerciseId: int, relation(parent=exercise)\nequipmentId: int, relation(parent=equipment_catalog)\nrequired: bool'),
'SocietyEquipment':('society_equipment','societyId: int, relation(parent=society)\nequipmentId: int, relation(parent=equipment_catalog)\nlabel: String\nquantity: int\nstatus: String\nlocationLabel: String\nlastServicedAt: DateTime?'),
'ExerciseAlternative':('exercise_alternative','sourceExerciseId: int, relation(parent=exercise)\nalternativeExerciseId: int, relation(parent=exercise)\nsimilarityScore: double\nnotes: String'),
'MaintenanceIssue':('maintenance_issue','societyId: int, relation(parent=society)\nsocietyEquipmentId: int, relation(parent=society_equipment)\nreportedBy: int, relation(parent=user_profile)\ntitle: String\ndescription: String\nseverity: String\nstatus: String\nphotoPath: String?\ncreatedAt: DateTime\nresolvedAt: DateTime?'),
'WorkoutPlan':('workout_plan','userId: int, relation(parent=user_profile)\ntitle: String\ncreatedByType: String\ntarget: String\nplannedDurationMin: int\ncreatedAt: DateTime\nstatus: String'),
'WorkoutPlanItem':('workout_plan_item','planId: int, relation(parent=workout_plan)\nexerciseId: int, relation(parent=exercise)\norderIndex: int\ntargetSets: int\ntargetRepsText: String\nsuggestedWeight: double?\nrestSeconds: int\nrationale: String'),
'WorkoutSession':('workout_session','userId: int, relation(parent=user_profile)\nplanId: int, relation(parent=workout_plan)\ntitle: String\nstartedAt: DateTime\nendedAt: DateTime?\ndurationMin: int?\nnotes: String\nperceivedEffort: double?'),
'WorkoutSet':('workout_set','sessionId: int, relation(parent=workout_session)\nexerciseId: int, relation(parent=exercise)\nsetNumber: int\nreps: int?\nweightKg: double?\ndurationSec: int?\nrpe: double?\ncompletedAt: DateTime'),
'TrainingReadiness':('training_readiness','userId: int, relation(parent=user_profile)\nmuscleGroupId: int, relation(parent=muscle_group)\nmuscleName: String\ntrainingLoadScore: double\nreadinessBand: String\nlastTrainedAt: DateTime?\ncomputedAt: DateTime\nexplanation: String'),
'FormAnalysis':('form_analysis','userId: int, relation(parent=user_profile)\nexerciseId: int, relation(parent=exercise)\ncheckpoint: String\ncapturedAt: DateTime\nanalysisType: String\nresultBand: String\nconfidence: double\nsummary: String\nretainedImagePath: String?'),
'FormMetric':('form_metric','formAnalysisId: int, relation(parent=form_analysis)\nmetricName: String\nmeasuredValue: double\nunit: String\ntargetRangeText: String\nstatus: String\nconfidence: double\ncue: String'),
'CommunityEvent':('community_event','societyId: int, relation(parent=society)\norganizerUserId: int, relation(parent=user_profile)\ntitle: String\ndescription: String\ncategory: String\nstartsAt: DateTime\nendsAt: DateTime\nlatitude: double\nlongitude: double\nvenueLabel: String\ncapacity: int\nstatus: String\nisDemo: bool'),
'EventParticipant':('event_participant','eventId: int, relation(parent=community_event)\nuserId: int, relation(parent=user_profile)\njoinedAt: DateTime\nstatus: String'),
'ExternalEventCache':('external_event_cache','provider: String\nproviderEventId: String\nqueryKey: String\ntitle: String\ncategory: String\nstartsAt: DateTime\nlatitude: double\nlongitude: double\nvenueLabel: String\nsourceUrl: String\nrawHash: String\nfetchedAt: DateTime\nexpiresAt: DateTime'),
'AgentConversation':('agent_conversation','userId: int, relation(parent=user_profile)\ntitle: String\ncreatedAt: DateTime\nupdatedAt: DateTime'),
'AgentMessage':('agent_message','conversationId: int, relation(parent=agent_conversation)\nrole: String\ncontent: String\ncreatedAt: DateTime'),
'AgentAction':('agent_action','conversationId: int, relation(parent=agent_conversation)\nuserId: int, relation(parent=user_profile)\ntoolName: String\nrequestSummary: String\nresultSummary: String\nstatus: String\ncreatedAt: DateTime\ndurationMs: int'),
'Notification':('notification','userId: int, relation(parent=user_profile)\ntype: String\ntitle: String\nbody: String\nreadAt: DateTime?\ncreatedAt: DateTime'),
'PlanDetail':(None,'plan: WorkoutPlan\nitems: List<WorkoutPlanItem>\nexercises: List<Exercise>'),
'SessionDetail':(None,'session: WorkoutSession\nsets: List<WorkoutSet>\nplan: PlanDetail'),
'DashboardData':(None,'profile: UserProfile\nsociety: Society\nequipment: List<SocietyEquipment>\nreadiness: List<TrainingReadiness>\nrecentSessions: List<WorkoutSession>\nevents: List<CommunityEvent>\ncompletedSets: int\nvolumeKg: double'),
'DiscoverData':(None,'community: List<CommunityEvent>\nexternal: List<ExternalEventCache>\njoinedEventIds: List<int>\nproviderStatus: String'),
'AgentReply':(None,'conversationId: int\nmessage: String\nactions: List<AgentAction>\nplanId: int?'),
'FormResult':(None,'analysis: FormAnalysis\nmetrics: List<FormMetric>'),
'GymException':(None,'message: String')}
unique={'Society':'inviteCode','UserProfile':'authUserId','SocietyMembership':'societyId, userId','Exercise':'slug','MuscleGroup':'name','EquipmentCatalog':'name','ExerciseMuscle':'exerciseId, muscleGroupId','ExerciseEquipment':'exerciseId, equipmentId','ExerciseAlternative':'sourceExerciseId, alternativeExerciseId','TrainingReadiness':'userId, muscleGroupId','EventParticipant':'eventId, userId'}
import re
for name,(table,fields) in models.items():
    filename=re.sub(r'(?<!^)(?=[A-Z])','_',name).lower()
    content=('exception' if name=='GymException' else 'class')+': '+name+'\n'
    if table: content+='table: '+table+'\n'
    content+='fields:\n'+''.join('  '+line+'\n' for line in fields.splitlines())
    indexes=[]
    if name in unique: indexes.append(f'  {filename}_unique:\n    fields: {unique[name]}\n    unique: true\n')
    if table:
        first=fields.split(':')[0]
        if first not in unique.get(name,'').split(', '): indexes.append(f'  {filename}_lookup:\n    fields: {first}\n')
    if indexes: content+='indexes:\n'+''.join(indexes)
    (root/(filename+'.spy.yaml')).write_text(content)
print('Created',len(models),'typed model definitions')
