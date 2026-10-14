# WorkManager (a transitive plugin dependency) creates its Room database
# reflectively at startup. Without these rules R8 strips the generated
# constructor and release builds crash in WorkDatabase initialization.
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
