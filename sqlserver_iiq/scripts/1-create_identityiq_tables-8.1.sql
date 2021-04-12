--
-- This script is a SAMPLE and can be modified as appropriate by the
-- customer as long as the equivalent tables and indexes are created.
-- The database name, user, and password must match those defined in
-- iiq.properties in the IdentityIQ installation.
--

-- Note that we do not specify a COLLATE.
-- IdentityIQ requires a case-insensitive collation.
CREATE DATABASE identityiq
GO

--create a sql server login with which to connect
CREATE LOGIN [identityiq] WITH PASSWORD='identityiq',
DEFAULT_DATABASE=identityiq
GO

USE identityiq
GO

--create a user in our db associated with our server login and our schema
CREATE USER identityiq FOR LOGIN identityiq WITH DEFAULT_SCHEMA =
identityiq
GO

-- create a schema
CREATE SCHEMA identityiq AUTHORIZATION identityiq
GO

--grant permissions
grant select,insert,update,delete to identityiq
GO

--this makes our default user the db owner, so it can be
--used to run upgrade scripts.  This is a convenience for
--non-production environments and is not necessary for 
--normal IdentityIQ operation.  It is recommended to remove
--this in production environments and run the upgrade scripts
--as another user with db_owner rights.
EXEC sp_addrolemember 'db_owner', 'identityiq'
GO

-- Enable automatic snapshot isolation 

ALTER DATABASE identityiq SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE identityiq SET READ_COMMITTED_SNAPSHOT ON
GO

CREATE DATABASE identityiqPlugin
GO

--create a sql server login with which to connect
CREATE LOGIN [identityiqPlugin] WITH PASSWORD='identityiqPlugin',
DEFAULT_DATABASE=identityiqPlugin
GO

USE identityiqPlugin
GO

--create a user in our db associated with our server login and our schema
CREATE USER identityiqPlugin FOR LOGIN identityiqPlugin WITH DEFAULT_SCHEMA =
identityiqPlugin
GO

-- create a schema
CREATE SCHEMA identityiqPlugin AUTHORIZATION identityiqPlugin
GO

--grant permissions
grant select,insert,update,delete,create table to identityiqPlugin
GO

--this makes our default user the db owner, so it can be
--used to run scripts.
EXEC sp_addrolemember 'db_owner', 'identityiqPlugin'
GO

-- Enable automatic snapshot isolation

ALTER DATABASE identityiqPlugin SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE identityiqPlugin SET READ_COMMITTED_SNAPSHOT ON
GO

USE identityiq
GO
-- From the Quartz 1.5.2 Distribution
--
-- IdentityIQ NOTES:
--
-- Since things like Application names can make their way into TaskSchedule
-- object names, we are forced to modify the Quartz schema in places where
-- the original column size is insufficient. Thus JOB_NAME and TRIGGER_NAME
-- have been increased from NVARCHAR(80) to NVARCHAR(338).
--
-- Future upgrades to Quartz will have to carry forward these changes.
-- 
--

CREATE TABLE identityiq.QRTZ221_CALENDARS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [CALENDAR_NAME] [NVARCHAR] (80)  NOT NULL ,
  [CALENDAR] [IMAGE] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_CRON_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [CRON_EXPRESSION] [NVARCHAR] (80)  NOT NULL ,
  [TIME_ZONE_ID] [NVARCHAR] (80)
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_FIRED_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [ENTRY_ID] [NVARCHAR] (95)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [INSTANCE_NAME] [NVARCHAR] (80)  NOT NULL ,
  [FIRED_TIME] [BIGINT] NOT NULL ,
  [SCHED_TIME] [BIGINT] NOT NULL ,
  [PRIORITY] [INTEGER] NOT NULL ,
  [STATE] [NVARCHAR] (16)  NOT NULL,
  [JOB_NAME] [NVARCHAR] (338)  NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NULL ,
  [IS_NONCONCURRENT] [NVARCHAR] (1)  NULL ,
  [REQUESTS_RECOVERY] [NVARCHAR] (1)  NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_PAUSED_TRIGGER_GRPS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_SCHEDULER_STATE (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [INSTANCE_NAME] [NVARCHAR] (80)  NOT NULL ,
  [LAST_CHECKIN_TIME] [BIGINT] NOT NULL ,
  [CHECKIN_INTERVAL] [BIGINT] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_LOCKS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [LOCK_NAME] [NVARCHAR] (40)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_JOB_DETAILS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [JOB_NAME] [NVARCHAR] (338)  NOT NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [DESCRIPTION] [NVARCHAR] (120) NULL ,
  [JOB_CLASS_NAME] [NVARCHAR] (128)  NOT NULL ,
  [IS_DURABLE] [NVARCHAR] (1)  NOT NULL ,
  [IS_NONCONCURRENT] [NVARCHAR] (1)  NOT NULL ,
  [IS_UPDATE_DATA] [NVARCHAR] (1)  NOT NULL ,
  [REQUESTS_RECOVERY] [NVARCHAR] (1)  NOT NULL ,
  [JOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [REPEAT_COUNT] [BIGINT] NOT NULL ,
  [REPEAT_INTERVAL] [BIGINT] NOT NULL ,
  [TIMES_TRIGGERED] [BIGINT] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.[QRTZ221_SIMPROP_TRIGGERS] (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [STR_PROP_1] [VARCHAR] (512) NULL,
  [STR_PROP_2] [VARCHAR] (512) NULL,
  [STR_PROP_3] [VARCHAR] (512) NULL,
  [INT_PROP_1] [INT] NULL,
  [INT_PROP_2] [INT] NULL,
  [LONG_PROP_1] [BIGINT] NULL,
  [LONG_PROP_2] [BIGINT] NULL,
  [DEC_PROP_1] [NUMERIC] (13,4) NULL,
  [DEC_PROP_2] [NUMERIC] (13,4) NULL,
  [BOOL_PROP_1] [VARCHAR] (1) NULL,
  [BOOL_PROP_2] [VARCHAR] (1) NULL,
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_BLOB_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [BLOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

CREATE TABLE identityiq.QRTZ221_TRIGGERS (
  [SCHED_NAME] [VARCHAR] (120)  NOT NULL ,
  [TRIGGER_NAME] [NVARCHAR] (338)  NOT NULL ,
  [TRIGGER_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [JOB_NAME] [NVARCHAR] (338)  NOT NULL ,
  [JOB_GROUP] [NVARCHAR] (32)  NOT NULL ,
  [DESCRIPTION] [VARCHAR] (250) NULL ,
  [NEXT_FIRE_TIME] [BIGINT] NULL ,
  [PREV_FIRE_TIME] [BIGINT] NULL ,
  [PRIORITY] [INTEGER] NULL ,
  [TRIGGER_STATE] [VARCHAR] (16)  NOT NULL ,
  [TRIGGER_TYPE] [VARCHAR] (8)  NOT NULL ,
  [START_TIME] [BIGINT] NOT NULL ,
  [END_TIME] [BIGINT] NULL ,
  [CALENDAR_NAME] [VARCHAR] (200)  NULL ,
  [MISFIRE_INSTR] [SMALLINT] NULL ,
  [JOB_DATA] [IMAGE] NULL
) ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CALENDARS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_CALENDARS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [CALENDAR_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CRON_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_CRON_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_FIRED_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_FIRED_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [ENTRY_ID]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_PAUSED_TRIGGER_GRPS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_PAUSED_TRIGGER_GRPS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_SCHEDULER_STATE WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_SCHEDULER_STATE] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [INSTANCE_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_LOCKS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_LOCKS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [LOCK_NAME]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_JOB_DETAILS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_JOB_DETAILS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_SIMPLE_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_TRIGGERS WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ221_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  )  ON [PRIMARY]
GO

ALTER TABLE identityiq.QRTZ221_CRON_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_CRON_TRIGGERS_QRTZ221_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES identityiq.QRTZ221_TRIGGERS (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE
GO

ALTER TABLE identityiq.QRTZ221_SIMPLE_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_SIMPLE_TRIGGERS_QRTZ221_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES identityiq.QRTZ221_TRIGGERS (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE
GO

ALTER TABLE identityiq.QRTZ221_TRIGGERS ADD
  CONSTRAINT [FK_QRTZ221_TRIGGERS_QRTZ221_JOB_DETAILS] FOREIGN KEY
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  ) REFERENCES identityiq.QRTZ221_JOB_DETAILS (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  )
GO

INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'TRIGGER_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'JOB_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'CALENDAR_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'STATE_ACCESS');
GO
INSERT INTO identityiq.QRTZ221_LOCKS VALUES('QuartzScheduler', 'MISFIRE_ACCESS');
GO

create index idx_qrtz_j_req_recovery on identityiq.QRTZ221_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
GO

create index idx_qrtz_j_grp on identityiq.QRTZ221_JOB_DETAILS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_j on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_jg on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_t_c on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
GO

create index idx_qrtz_t_g on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
GO

create index idx_qrtz_t_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
GO

create index idx_qrtz_t_n_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_t_n_g_state on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_t_next_fire_time on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_st on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_misfire on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
GO

create index idx_qrtz_t_nft_st_misfire on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
GO

create index idx_qrtz_t_nft_st_misfire_grp on identityiq.QRTZ221_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);
GO

create index idx_qrtz_ft_trig_inst_name on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
GO

create index idx_qrtz_ft_inst_job_req_rcvry on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
GO

create index idx_qrtz_ft_j_g on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
GO

create index idx_qrtz_ft_jg on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
GO

create index idx_qrtz_ft_t_g on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
GO

create index idx_qrtz_ft_tg on identityiq.QRTZ221_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
GO

-- End Quartz configuration

    create table identityiq.spt_account_group (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description nvarchar(1024),
        native_identity nvarchar(322),
        reference_attribute nvarchar(128),
        member_attribute nvarchar(128),
        last_refresh numeric(19,0),
        last_target_aggregation numeric(19,0),
        uncorrelated tinyint,
        attributes nvarchar(max),
        key1 nvarchar(128),
        key2 nvarchar(128),
        key3 nvarchar(128),
        key4 nvarchar(128),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        application nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_account_group_inheritance (
       account_group nvarchar(32) not null,
        idx int not null,
        inherits_from nvarchar(32) not null,
        primary key (account_group, idx)
    );
    GO

    create table identityiq.spt_account_group_perms (
       accountgroup nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        annotation nvarchar(255),
        primary key (accountgroup, idx)
    );
    GO

    create table identityiq.spt_account_group_target_perms (
       accountgroup nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        annotation nvarchar(255),
        primary key (accountgroup, idx)
    );
    GO

    create table identityiq.spt_activity_constraint (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(2000),
        description nvarchar(4000),
        violation_owner_type nvarchar(255),
        compensating_control nvarchar(max),
        disabled tinyint,
        weight int,
        remediation_advice nvarchar(max),
        violation_summary nvarchar(max),
        identity_filters nvarchar(max),
        activity_filters nvarchar(max),
        time_periods nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        policy nvarchar(32),
        violation_owner nvarchar(32),
        violation_owner_rule nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_activity_data_source (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        collector nvarchar(255),
        type nvarchar(255),
        configuration nvarchar(max),
        last_refresh numeric(19,0),
        targets nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        correlation_rule nvarchar(32),
        transformation_rule nvarchar(32),
        application nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_activity_time_periods (
       application_activity nvarchar(32) not null,
        idx int not null,
        time_period nvarchar(32) not null,
        primary key (application_activity, idx)
    );
    GO

    create table identityiq.spt_alert (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        extended1 nvarchar(255),
        attributes nvarchar(max),
        alert_date numeric(19,0),
        native_id nvarchar(255),
        target_id nvarchar(255),
        target_type nvarchar(255),
        target_display_name nvarchar(255),
        last_processed numeric(19,0),
        display_name nvarchar(128),
        name nvarchar(255),
        type nvarchar(255),
        source nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_alert_action (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        alert_def nvarchar(max),
        action_type nvarchar(255),
        result_id nvarchar(255),
        result nvarchar(max),
        alert nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_alert_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        match_config nvarchar(max),
        disabled tinyint,
        name nvarchar(128) not null,
        description nvarchar(1024),
        display_name nvarchar(128),
        action_config nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_app_dependencies (
       application nvarchar(32) not null,
        idx int not null,
        dependency nvarchar(32) not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_application (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        extended4 nvarchar(450),
        name nvarchar(128) not null,
        proxied_name nvarchar(128),
        app_cluster nvarchar(255),
        icon nvarchar(255),
        connector nvarchar(255),
        type nvarchar(255),
        features_string nvarchar(512),
        aggregation_types nvarchar(128),
        profile_class nvarchar(255),
        authentication_resource tinyint,
        case_insensitive tinyint,
        authoritative tinyint,
        maintenance_expiration numeric(19,0),
        logical tinyint,
        supports_provisioning tinyint,
        supports_authenticate tinyint,
        supports_account_only tinyint,
        supports_additional_accounts tinyint,
        no_aggregation tinyint,
        sync_provisioning tinyint,
        attributes nvarchar(max),
        templates nvarchar(max),
        provisioning_forms nvarchar(max),
        provisioning_config nvarchar(max),
        manages_other_apps tinyint not null,
        managed_attr_customize_rule nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        proxy nvarchar(32),
        correlation_rule nvarchar(32),
        creation_rule nvarchar(32),
        manager_correlation_rule nvarchar(32),
        customization_rule nvarchar(32),
        account_correlation_config nvarchar(32),
        scorecard nvarchar(32),
        target_source nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_application_remediators (
       application nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_application_activity (
       id nvarchar(32) not null,
        time_stamp numeric(19,0),
        source_application nvarchar(128),
        action nvarchar(255),
        result nvarchar(255),
        data_source nvarchar(128),
        instance nvarchar(128),
        username nvarchar(128),
        target nvarchar(128),
        info nvarchar(512),
        identity_id nvarchar(128),
        identity_name nvarchar(128),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_application_schema (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        object_type nvarchar(255),
        aggregation_type nvarchar(128),
        native_object_type nvarchar(255),
        identity_attribute nvarchar(255),
        display_attribute nvarchar(255),
        instance_attribute nvarchar(255),
        description_attribute nvarchar(255),
        group_attribute nvarchar(255),
        hierarchy_attribute nvarchar(255),
        reference_attribute nvarchar(255),
        include_permissions tinyint,
        index_permissions tinyint,
        child_hierarchy tinyint,
        perm_remed_mod_type nvarchar(255),
        config nvarchar(max),
        features_string nvarchar(512),
        association_schema_name nvarchar(255),
        creation_rule nvarchar(32),
        customization_rule nvarchar(32),
        correlation_rule nvarchar(32),
        refresh_rule nvarchar(32),
        application nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_application_scorecard (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        incomplete tinyint,
        composite_score int,
        attributes nvarchar(max),
        items nvarchar(max),
        application_id nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_app_secondary_owners (
       application nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_arch_cert_item_apps (
       arch_cert_item_id nvarchar(32) not null,
        idx int not null,
        application_name nvarchar(255),
        primary key (arch_cert_item_id, idx)
    );
    GO

    create table identityiq.spt_attachment (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(256),
        description nvarchar(256),
        content varbinary(MAX),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_audit_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        disabled tinyint,
        classes nvarchar(max),
        resources nvarchar(max),
        attributes nvarchar(max),
        actions nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_audit_event (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        interface nvarchar(128),
        source nvarchar(128),
        action nvarchar(128),
        target nvarchar(255),
        application nvarchar(128),
        account_name nvarchar(256),
        instance nvarchar(128),
        attribute_name nvarchar(128),
        attribute_value nvarchar(450),
        tracking_id nvarchar(128),
        attributes nvarchar(max),
        string1 nvarchar(450),
        string2 nvarchar(450),
        string3 nvarchar(450),
        string4 nvarchar(450),
        server_host nvarchar(128),
        client_host nvarchar(128),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_authentication_answer (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        identity_id nvarchar(32),
        question_id nvarchar(32),
        answer nvarchar(512),
        owner nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_authentication_question (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        question nvarchar(1024),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_batch_request (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        file_name nvarchar(255),
        header nvarchar(4000),
        run_date numeric(19,0),
        completed_date numeric(19,0),
        record_count int,
        completed_count int,
        error_count int,
        invalid_count int,
        message nvarchar(4000),
        error_message nvarchar(max),
        file_contents nvarchar(max),
        status nvarchar(255),
        run_config nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_batch_request_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        request_data nvarchar(4000),
        status nvarchar(255),
        message nvarchar(4000),
        error_message nvarchar(max),
        result nvarchar(255),
        identity_request_id nvarchar(255),
        target_identity_id nvarchar(255),
        batch_request_id nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        extended4 nvarchar(450),
        name nvarchar(128) not null,
        display_name nvarchar(128),
        displayable_name nvarchar(128),
        disabled tinyint,
        risk_score_weight int,
        activity_config nvarchar(max),
        mining_statistics nvarchar(max),
        attributes nvarchar(max),
        type nvarchar(128),
        selector nvarchar(max),
        provisioning_plan nvarchar(max),
        templates nvarchar(max),
        provisioning_forms nvarchar(max),
        or_profiles tinyint,
        activation_date numeric(19,0),
        deactivation_date numeric(19,0),
        pending_delete tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        join_rule nvarchar(32),
        pending_workflow nvarchar(32),
        role_index nvarchar(32),
        scorecard nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle_archive (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        source_id nvarchar(128),
        version int,
        creator nvarchar(128),
        archive nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_bundle_children (
       bundle nvarchar(32) not null,
        idx int not null,
        child nvarchar(32) not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_bundle_permits (
       bundle nvarchar(32) not null,
        idx int not null,
        child nvarchar(32) not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_bundle_requirements (
       bundle nvarchar(32) not null,
        idx int not null,
        child nvarchar(32) not null,
        primary key (bundle, idx)
    );
    GO

    create table identityiq.spt_capability (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        display_name nvarchar(128),
        applies_to_analyzer tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_capability_children (
       capability_id nvarchar(32) not null,
        idx int not null,
        child_id nvarchar(32) not null,
        primary key (capability_id, idx)
    );
    GO

    create table identityiq.spt_capability_rights (
       capability_id nvarchar(32) not null,
        idx int not null,
        right_id nvarchar(32) not null,
        primary key (capability_id, idx)
    );
    GO

    create table identityiq.spt_category (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        targets nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_cert_action_assoc (
       parent_id nvarchar(32) not null,
        idx int not null,
        child_id nvarchar(32) not null,
        primary key (parent_id, idx)
    );
    GO

    create table identityiq.spt_certification (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        attributes nvarchar(max),
        iiqlock nvarchar(128),
        name nvarchar(256),
        short_name nvarchar(255),
        description nvarchar(1024),
        creator nvarchar(255),
        complete tinyint,
        complete_hierarchy tinyint,
        signed numeric(19,0),
        approver_rule nvarchar(512),
        finished numeric(19,0),
        expiration numeric(19,0),
        automatic_closing_date numeric(19,0),
        application_id nvarchar(255),
        manager nvarchar(255),
        group_definition nvarchar(512),
        group_definition_id nvarchar(128),
        group_definition_name nvarchar(255),
        comments nvarchar(max),
        error nvarchar(max),
        entities_to_refresh nvarchar(max),
        commands nvarchar(max),
        activated numeric(19,0),
        total_entities int,
        excluded_entities int,
        completed_entities int,
        delegated_entities int,
        percent_complete int,
        certified_entities int,
        cert_req_entities int,
        overdue_entities int,
        total_items int,
        excluded_items int,
        completed_items int,
        delegated_items int,
        item_percent_complete int,
        certified_items int,
        cert_req_items int,
        overdue_items int,
        remediations_kicked_off int,
        remediations_completed int,
        total_violations int not null,
        violations_allowed int not null,
        violations_remediated int not null,
        violations_acknowledged int not null,
        total_roles int not null,
        roles_approved int not null,
        roles_allowed int not null,
        roles_remediated int not null,
        total_exceptions int not null,
        exceptions_approved int not null,
        exceptions_allowed int not null,
        exceptions_remediated int not null,
        total_grp_perms int not null,
        grp_perms_approved int not null,
        grp_perms_remediated int not null,
        total_grp_memberships int not null,
        grp_memberships_approved int not null,
        grp_memberships_remediated int not null,
        total_accounts int not null,
        accounts_approved int not null,
        accounts_allowed int not null,
        accounts_remediated int not null,
        total_profiles int not null,
        profiles_approved int not null,
        profiles_remediated int not null,
        total_scopes int not null,
        scopes_approved int not null,
        scopes_remediated int not null,
        total_capabilities int not null,
        capabilities_approved int not null,
        capabilities_remediated int not null,
        total_permits int not null,
        permits_approved int not null,
        permits_remediated int not null,
        total_requirements int not null,
        requirements_approved int not null,
        requirements_remediated int not null,
        total_hierarchies int not null,
        hierarchies_approved int not null,
        hierarchies_remediated int not null,
        type nvarchar(255),
        task_schedule_id nvarchar(255),
        trigger_id nvarchar(128),
        certification_definition_id nvarchar(128),
        phase nvarchar(255),
        next_phase_transition numeric(19,0),
        phase_config nvarchar(max),
        process_revokes_immediately tinyint,
        next_remediation_scan numeric(19,0),
        entitlement_granularity nvarchar(255),
        bulk_reassignment tinyint,
        continuous tinyint,
        continuous_config nvarchar(max),
        next_cert_required_scan numeric(19,0),
        next_overdue_scan numeric(19,0),
        exclude_inactive tinyint,
        immutable tinyint,
        electronically_signed tinyint,
        self_cert_reassignment tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        parent nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_def_tags (
       cert_def_id nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (cert_def_id, idx)
    );
    GO

    create table identityiq.spt_certification_groups (
       certification_id nvarchar(32) not null,
        idx int not null,
        group_id nvarchar(32) not null,
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_certification_tags (
       certification_id nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_certification_action (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        owner_name nvarchar(255),
        email_template nvarchar(255),
        comments nvarchar(max),
        expiration datetime2,
        work_item nvarchar(255),
        completion_state nvarchar(255),
        completion_comments nvarchar(max),
        completion_user nvarchar(128),
        actor_name nvarchar(128),
        actor_display_name nvarchar(128),
        acting_work_item nvarchar(255),
        description nvarchar(1024),
        status nvarchar(255),
        decision_date numeric(19,0),
        decision_certification_id nvarchar(128),
        reviewed tinyint,
        bulk_certified tinyint,
        mitigation_expiration numeric(19,0),
        remediation_action nvarchar(255),
        remediation_details nvarchar(max),
        additional_actions nvarchar(max),
        revoke_account tinyint,
        ready_for_remediation tinyint,
        remediation_kicked_off tinyint,
        remediation_completed tinyint,
        auto_decision tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        source_action nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_archive (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(256),
        certification_id nvarchar(255),
        certification_group_id nvarchar(255),
        signed numeric(19,0),
        expiration numeric(19,0),
        creator nvarchar(128),
        comments nvarchar(max),
        archive nvarchar(max),
        immutable tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_challenge (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        owner_name nvarchar(255),
        email_template nvarchar(255),
        comments nvarchar(max),
        expiration datetime2,
        work_item nvarchar(255),
        completion_state nvarchar(255),
        completion_comments nvarchar(max),
        completion_user nvarchar(128),
        actor_name nvarchar(128),
        actor_display_name nvarchar(128),
        acting_work_item nvarchar(255),
        description nvarchar(1024),
        challenged tinyint,
        decision nvarchar(255),
        decision_comments nvarchar(max),
        decider_name nvarchar(255),
        challenge_decision_expired tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(255) not null,
        description nvarchar(1024),
        attributes nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_delegation (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        owner_name nvarchar(255),
        email_template nvarchar(255),
        comments nvarchar(max),
        expiration datetime2,
        work_item nvarchar(255),
        completion_state nvarchar(255),
        completion_comments nvarchar(max),
        completion_user nvarchar(128),
        actor_name nvarchar(128),
        actor_display_name nvarchar(128),
        acting_work_item nvarchar(255),
        description nvarchar(1024),
        review_required tinyint,
        revoked tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_entity (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        completed numeric(19,0),
        summary_status nvarchar(255),
        continuous_state nvarchar(255),
        last_decision numeric(19,0),
        next_continuous_state_change numeric(19,0),
        overdue_date numeric(19,0),
        has_differences tinyint,
        action_required tinyint,
        target_display_name nvarchar(255),
        target_name nvarchar(255),
        target_id nvarchar(255),
        custom1 nvarchar(450),
        custom2 nvarchar(450),
        custom_map nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        action nvarchar(32),
        delegation nvarchar(32),
        type nvarchar(255),
        bulk_certified tinyint,
        attributes nvarchar(max),
        identity_id nvarchar(450),
        firstname nvarchar(255),
        lastname nvarchar(255),
        composite_score int,
        snapshot_id nvarchar(255),
        differences nvarchar(max),
        new_user tinyint,
        account_group nvarchar(450),
        application nvarchar(255),
        native_identity nvarchar(322),
        reference_attribute nvarchar(255),
        schema_object_type nvarchar(255),
        certification_id nvarchar(32),
        pending_certification nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_group (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(256),
        type nvarchar(255),
        status nvarchar(255),
        attributes nvarchar(max),
        total_certifications int,
        percent_complete int,
        completed_certifications int,
        certification_definition nvarchar(32),
        messages nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_certification_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        completed numeric(19,0),
        summary_status nvarchar(255),
        continuous_state nvarchar(255),
        last_decision numeric(19,0),
        next_continuous_state_change numeric(19,0),
        overdue_date numeric(19,0),
        has_differences tinyint,
        action_required tinyint,
        target_display_name nvarchar(255),
        target_name nvarchar(255),
        target_id nvarchar(255),
        custom1 nvarchar(450),
        custom2 nvarchar(450),
        custom_map nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        action nvarchar(32),
        delegation nvarchar(32),
        bundle nvarchar(255),
        type nvarchar(255),
        sub_type nvarchar(255),
        bundle_assignment_id nvarchar(128),
        certification_entity_id nvarchar(32),
        needs_refresh tinyint,
        exception_application nvarchar(128),
        exception_attribute_name nvarchar(255),
        exception_attribute_value nvarchar(2048),
        exception_permission_target nvarchar(255),
        exception_permission_right nvarchar(255),
        policy_violation nvarchar(max),
        violation_summary nvarchar(256),
        wake_up_date numeric(19,0),
        reminders_sent int,
        needs_continuous_flush tinyint,
        phase nvarchar(255),
        next_phase_transition numeric(19,0),
        finished_date numeric(19,0),
        recommend_value nvarchar(100),
        attributes nvarchar(max),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        extended4 nvarchar(450),
        extended5 nvarchar(450),
        exception_entitlements nvarchar(32),
        challenge nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_certifiers (
       certification_id nvarchar(32) not null,
        idx int not null,
        certifier nvarchar(255),
        primary key (certification_id, idx)
    );
    GO

    create table identityiq.spt_cert_item_applications (
       certification_item_id nvarchar(32) not null,
        idx int not null,
        application_name nvarchar(255),
        primary key (certification_item_id, idx)
    );
    GO

    create table identityiq.spt_cert_item_classifications (
       certification_item nvarchar(32),
        classification_name nvarchar(255)
    );
    GO

    create table identityiq.spt_child_certification_ids (
       certification_archive_id nvarchar(32) not null,
        idx int not null,
        child_id nvarchar(255),
        primary key (certification_archive_id, idx)
    );
    GO

    create table identityiq.spt_classification (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        display_name nvarchar(128),
        displayable_name nvarchar(128),
        attributes nvarchar(max),
        origin nvarchar(128),
        type nvarchar(128),
        primary key (id)
    );
    GO

    create table identityiq.spt_configuration (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        attributes nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_correlation_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(256),
        attribute_assignments nvarchar(max),
        direct_assignments nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_custom (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description nvarchar(1024),
        attributes nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_database_version (
       name nvarchar(255) not null,
        system_version nvarchar(128),
        schema_version nvarchar(128),
        primary key (name)
    );
    GO

    create table identityiq.spt_deleted_object (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        uuid nvarchar(128),
        name nvarchar(128),
        native_identity nvarchar(322) not null,
        last_refresh numeric(19,0),
        object_type nvarchar(128),
        application nvarchar(32),
        attributes nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_dictionary (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_dictionary_term (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        value nvarchar(128) not null,
        dictionary_id nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_dynamic_scope (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        selector nvarchar(max),
        allow_all tinyint,
        population_request_authority nvarchar(max),
        managed_attr_request_control nvarchar(32),
        managed_attr_remove_control nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        role_request_control nvarchar(32),
        application_request_control nvarchar(32),
        role_remove_control nvarchar(32),
        application_remove_control nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_dynamic_scope_exclusions (
       dynamic_scope_id nvarchar(32) not null,
        idx int not null,
        identity_id nvarchar(32) not null,
        primary key (dynamic_scope_id, idx)
    );
    GO

    create table identityiq.spt_dynamic_scope_inclusions (
       dynamic_scope_id nvarchar(32) not null,
        idx int not null,
        identity_id nvarchar(32) not null,
        primary key (dynamic_scope_id, idx)
    );
    GO

    create table identityiq.spt_email_template (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        from_address nvarchar(255),
        to_address nvarchar(255),
        cc_address nvarchar(255),
        bcc_address nvarchar(255),
        subject nvarchar(255),
        body nvarchar(max),
        signature nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_email_template_properties (
       id nvarchar(32) not null,
        name nvarchar(78) not null,
        value nvarchar(255),
        primary key (id, name)
    );
    GO

    create table identityiq.spt_entitlement_group (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        application nvarchar(32),
        instance nvarchar(128),
        native_identity nvarchar(322),
        display_name nvarchar(128),
        account_only tinyint not null,
        attributes nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        identity_id nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_entitlement_snapshot (
       id nvarchar(32) not null,
        application nvarchar(255),
        instance nvarchar(128),
        native_identity nvarchar(322),
        display_name nvarchar(450),
        account_only tinyint not null,
        attributes nvarchar(max),
        certification_item_id nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_file_bucket (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        file_index int,
        parent_id nvarchar(32),
        data varbinary(MAX),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_form (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(4000),
        hidden tinyint,
        type nvarchar(255),
        application nvarchar(32),
        sections nvarchar(max),
        buttons nvarchar(max),
        attributes nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_full_text_index (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        description nvarchar(1024),
        iiqlock nvarchar(128),
        last_refresh numeric(19,0),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_generic_constraint (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(2000),
        description nvarchar(4000),
        violation_owner_type nvarchar(255),
        compensating_control nvarchar(max),
        disabled tinyint,
        weight int,
        remediation_advice nvarchar(max),
        violation_summary nvarchar(max),
        arguments nvarchar(max),
        selectors nvarchar(max),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        policy nvarchar(32),
        violation_owner nvarchar(32),
        violation_owner_rule nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_group_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(255),
        description nvarchar(1024),
        filter nvarchar(max),
        last_refresh numeric(19,0),
        null_group tinyint,
        indexed tinyint,
        private tinyint,
        factory nvarchar(32),
        group_index nvarchar(32),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_group_factory (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(255),
        description nvarchar(1024),
        factory_attribute nvarchar(255),
        enabled tinyint,
        last_refresh numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        group_owner_rule nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_group_index (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        incomplete tinyint,
        composite_score int,
        attributes nvarchar(max),
        items nvarchar(max),
        business_role_score int,
        raw_business_role_score int,
        entitlement_score int,
        raw_entitlement_score int,
        policy_score int,
        raw_policy_score int,
        certification_score int,
        total_violations int,
        total_remediations int,
        total_delegations int,
        total_mitigations int,
        total_approvals int,
        definition nvarchar(32),
        name nvarchar(255),
        member_count int,
        band_count int,
        band1 int,
        band2 int,
        band3 int,
        band4 int,
        band5 int,
        band6 int,
        band7 int,
        band8 int,
        band9 int,
        band10 int,
        certifications_due int,
        certifications_on_time int,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_group_permissions (
       entitlement_group_id nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        annotation nvarchar(255),
        rights nvarchar(4000),
        attributes nvarchar(max),
        primary key (entitlement_group_id, idx)
    );
    GO

    create table identityiq.spt_identity (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        extended4 nvarchar(450),
        extended5 nvarchar(450),
        extended6 nvarchar(450),
        extended7 nvarchar(450),
        extended8 nvarchar(450),
        extended9 nvarchar(450),
        extended10 nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        protected tinyint,
        needs_refresh tinyint,
        iiqlock nvarchar(128),
        attributes nvarchar(max),
        display_name nvarchar(128),
        firstname nvarchar(128),
        lastname nvarchar(128),
        email nvarchar(128),
        manager_status tinyint,
        inactive tinyint,
        last_login numeric(19,0),
        last_refresh numeric(19,0),
        password nvarchar(450),
        password_expiration numeric(19,0),
        password_history nvarchar(2000),
        bundle_summary nvarchar(2000),
        assigned_role_summary nvarchar(2000),
        correlated tinyint,
        correlated_overridden tinyint,
        type nvarchar(128),
        software_version nvarchar(128),
        auth_lock_start numeric(19,0),
        failed_auth_question_attempts int,
        failed_login_attempts int,
        controls_assigned_scope tinyint,
        certifications nvarchar(max),
        activity_config nvarchar(max),
        preferences nvarchar(max),
        attribute_meta_data nvarchar(max),
        workgroup tinyint,
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        extended_identity1 nvarchar(32),
        extended_identity2 nvarchar(32),
        extended_identity3 nvarchar(32),
        extended_identity4 nvarchar(32),
        extended_identity5 nvarchar(32),
        manager nvarchar(32),
        administrator nvarchar(32),
        scorecard nvarchar(32),
        uipreferences nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_archive (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        source_id nvarchar(128),
        version int,
        creator nvarchar(128),
        archive nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_assigned_roles (
       identity_id nvarchar(32) not null,
        idx int not null,
        bundle nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_bundles (
       identity_id nvarchar(32) not null,
        idx int not null,
        bundle nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_capabilities (
       identity_id nvarchar(32) not null,
        idx int not null,
        capability_id nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_controlled_scopes (
       identity_id nvarchar(32) not null,
        idx int not null,
        scope_id nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_entitlement (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        start_date numeric(19,0),
        end_date numeric(19,0),
        attributes nvarchar(max),
        name nvarchar(255),
        value nvarchar(450),
        annotation nvarchar(450),
        display_name nvarchar(255),
        native_identity nvarchar(450),
        instance nvarchar(128),
        application nvarchar(32),
        identity_id nvarchar(32) not null,
        aggregation_state nvarchar(255),
        source nvarchar(64),
        assigned tinyint,
        allowed tinyint,
        granted_by_role tinyint,
        assigner nvarchar(128),
        assignment_id nvarchar(64),
        assignment_note nvarchar(1024),
        type nvarchar(255),
        request_item nvarchar(32),
        pending_request_item nvarchar(32),
        certification_item nvarchar(32),
        pending_certification_item nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_external_attr (
       id nvarchar(32) not null,
        object_id nvarchar(64),
        attribute_name nvarchar(64),
        value nvarchar(322),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_history_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        identity_id nvarchar(32),
        type nvarchar(255),
        certifiable_descriptor nvarchar(max),
        action nvarchar(max),
        certification_link nvarchar(max),
        comments nvarchar(max),
        certification_type nvarchar(255),
        status nvarchar(255),
        actor nvarchar(128),
        entry_date numeric(19,0),
        application nvarchar(128),
        instance nvarchar(128),
        account nvarchar(128),
        native_identity nvarchar(322),
        attribute nvarchar(450),
        value nvarchar(450),
        policy nvarchar(255),
        constraint_name nvarchar(2000),
        role nvarchar(255),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_request (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(255),
        state nvarchar(255),
        type nvarchar(255),
        source nvarchar(255),
        target_id nvarchar(128),
        target_display_name nvarchar(255),
        target_class nvarchar(255),
        requester_display_name nvarchar(255),
        requester_id nvarchar(128),
        end_date numeric(19,0),
        verified numeric(19,0),
        priority nvarchar(128),
        completion_status nvarchar(128),
        execution_status nvarchar(128),
        has_messages tinyint not null,
        external_ticket_id nvarchar(128),
        attributes nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_request_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        start_date numeric(19,0),
        end_date numeric(19,0),
        attributes nvarchar(max),
        name nvarchar(255),
        value nvarchar(450),
        annotation nvarchar(450),
        display_name nvarchar(255),
        native_identity nvarchar(450),
        instance nvarchar(128),
        application nvarchar(255),
        owner_name nvarchar(128),
        approver_name nvarchar(128),
        operation nvarchar(128),
        retries int,
        provisioning_engine nvarchar(255),
        approval_state nvarchar(128),
        provisioning_state nvarchar(128),
        compilation_status nvarchar(128),
        expansion_cause nvarchar(128),
        identity_request_id nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_role_metadata (
       identity_id nvarchar(32) not null,
        idx int not null,
        role_metadata_id nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_identity_snapshot (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        identity_id nvarchar(255),
        identity_name nvarchar(255),
        summary nvarchar(2000),
        differences nvarchar(2000),
        applications nvarchar(2000),
        scorecard nvarchar(max),
        attributes nvarchar(max),
        bundles nvarchar(max),
        exceptions nvarchar(max),
        links nvarchar(max),
        violations nvarchar(max),
        assigned_roles nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_trigger (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(256),
        description nvarchar(1024),
        disabled tinyint,
        type nvarchar(255),
        rule_id nvarchar(32),
        attribute_name nvarchar(256),
        old_value_filter nvarchar(256),
        new_value_filter nvarchar(256),
        selector nvarchar(max),
        handler nvarchar(256),
        parameters nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_workgroups (
       identity_id nvarchar(32) not null,
        idx int not null,
        workgroup nvarchar(32) not null,
        primary key (identity_id, idx)
    );
    GO

    create table identityiq.spt_integration_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(4000),
        executor nvarchar(255),
        exec_style nvarchar(255),
        role_sync_style nvarchar(255),
        template tinyint,
        maintenance_expiration numeric(19,0),
        signature nvarchar(max),
        attributes nvarchar(max),
        resources nvarchar(max),
        application_id nvarchar(32),
        role_sync_filter nvarchar(max),
        container_id nvarchar(32),
        assigned_scope nvarchar(32),
        plan_initializer nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_files (
       result nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (result, idx)
    );
    GO

    create table identityiq.spt_jasper_page_bucket (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        bucket_number int,
        handler_id nvarchar(128),
        xml nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_result (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        handler_id nvarchar(128),
        print_xml nvarchar(max),
        page_count int,
        pages_per_bucket int,
        handler_page_count int,
        attributes nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_jasper_template (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        design_xml nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_link (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        key1 nvarchar(450),
        key2 nvarchar(255),
        key3 nvarchar(255),
        key4 nvarchar(255),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        extended4 nvarchar(450),
        extended5 nvarchar(450),
        uuid nvarchar(128),
        display_name nvarchar(128),
        instance nvarchar(128),
        native_identity nvarchar(322) not null,
        last_refresh numeric(19,0),
        last_target_aggregation numeric(19,0),
        manually_correlated tinyint,
        entitlements tinyint not null,
        identity_id nvarchar(32),
        application nvarchar(32),
        attributes nvarchar(max),
        password_history nvarchar(2000),
        component_ids nvarchar(256),
        attribute_meta_data nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_link_external_attr (
       id nvarchar(32) not null,
        object_id nvarchar(64),
        attribute_name nvarchar(64),
        value nvarchar(322),
        primary key (id)
    );
    GO

    create table identityiq.spt_localized_attribute (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        name nvarchar(255),
        locale nvarchar(128),
        attribute nvarchar(128),
        value nvarchar(1024),
        target_class nvarchar(255),
        target_name nvarchar(255),
        target_id nvarchar(255),
        primary key (id)
    );
    GO

    create table identityiq.spt_managed_attribute (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        extended1 nvarchar(450),
        extended2 nvarchar(450),
        extended3 nvarchar(450),
        purview nvarchar(128),
        application nvarchar(32),
        type nvarchar(255),
        aggregated tinyint,
        attribute nvarchar(322),
        value nvarchar(450),
        hash nvarchar(128) not null,
        display_name nvarchar(450),
        displayable_name nvarchar(450),
        uuid nvarchar(128),
        attributes nvarchar(max),
        requestable tinyint,
        uncorrelated tinyint,
        last_refresh numeric(19,0),
        last_target_aggregation numeric(19,0),
        key1 nvarchar(128),
        key2 nvarchar(128),
        key3 nvarchar(128),
        key4 nvarchar(128),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_managed_attr_inheritance (
       managedattribute nvarchar(32) not null,
        idx int not null,
        inherits_from nvarchar(32) not null,
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_managed_attr_perms (
       managedattribute nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        annotation nvarchar(255),
        attributes nvarchar(max),
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_managed_attr_target_perms (
       managedattribute nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        annotation nvarchar(255),
        attributes nvarchar(max),
        primary key (managedattribute, idx)
    );
    GO

    create table identityiq.spt_message_template (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        text nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_mining_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        arguments nvarchar(max),
        app_constraints nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_mitigation_expiration (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        expiration numeric(19,0) not null,
        mitigator nvarchar(32) not null,
        comments nvarchar(max),
        identity_id nvarchar(32),
        certification_link nvarchar(max),
        certifiable_descriptor nvarchar(max),
        action nvarchar(255),
        action_parameters nvarchar(max),
        last_action_date numeric(19,0),
        role_name nvarchar(128),
        policy nvarchar(128),
        constraint_name nvarchar(2000),
        application nvarchar(128),
        instance nvarchar(128),
        native_identity nvarchar(322),
        account_display_name nvarchar(128),
        attribute_name nvarchar(450),
        attribute_value nvarchar(450),
        permission tinyint,
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_module (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        description nvarchar(512),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_monitoring_statistic (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        display_name nvarchar(128),
        description nvarchar(1024),
        value nvarchar(4000),
        value_type nvarchar(128),
        type nvarchar(128),
        attributes nvarchar(max),
        template tinyint,
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_monitoring_statistic_tags (
       statistic_id nvarchar(32) not null,
        elt nvarchar(32) not null
    );
    GO

    create table identityiq.spt_object_classification (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner_id nvarchar(32),
        owner_type nvarchar(128),
        source nvarchar(128),
        effective tinyint,
        classification_id nvarchar(32) not null,
        primary key (id)
    );
    GO

    create table identityiq.spt_object_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        object_attributes nvarchar(max),
        config_attributes nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_partition_result (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        stack nvarchar(max),
        attributes nvarchar(max),
        launcher nvarchar(255),
        host nvarchar(255),
        launched numeric(19,0),
        progress nvarchar(255),
        percent_complete int,
        type nvarchar(255),
        messages nvarchar(max),
        completed numeric(19,0),
        name nvarchar(255) not null,
        task_terminated tinyint,
        completion_status nvarchar(255),
        assigned_scope nvarchar(32),
        task_result nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_password_policy (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        name nvarchar(128) not null,
        description nvarchar(512),
        password_constraints nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_password_policy_holder (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        policy nvarchar(32),
        selector nvarchar(max),
        application nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_persisted_file (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(256),
        description nvarchar(1024),
        content_type nvarchar(128),
        content_length numeric(19,0),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_plugin (
       id nvarchar(32) not null,
        name nvarchar(255),
        created numeric(19,0),
        modified numeric(19,0),
        install_date numeric(19,0),
        display_name nvarchar(255),
        version nvarchar(255),
        disabled tinyint,
        right_required nvarchar(255),
        min_system_version nvarchar(255),
        max_system_version nvarchar(255),
        attributes nvarchar(max),
        position int,
        certification_level nvarchar(255),
        file_id nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_policy (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        template tinyint,
        type nvarchar(255),
        type_key nvarchar(255),
        executor nvarchar(255),
        config_page nvarchar(255),
        certification_actions nvarchar(255),
        violation_owner_type nvarchar(255),
        violation_owner nvarchar(32),
        state nvarchar(255),
        arguments nvarchar(max),
        signature nvarchar(max),
        alert nvarchar(max),
        assigned_scope nvarchar(32),
        violation_owner_rule nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_policy_violation (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(2000),
        description nvarchar(4000),
        identity_id nvarchar(32),
        renderer nvarchar(255),
        active tinyint,
        policy_id nvarchar(255),
        policy_name nvarchar(255),
        constraint_id nvarchar(255),
        status nvarchar(255),
        constraint_name nvarchar(2000),
        left_bundles nvarchar(max),
        right_bundles nvarchar(max),
        activity_id nvarchar(255),
        bundles_marked_for_remediation nvarchar(max),
        entitlements_marked_for_remed nvarchar(max),
        mitigator nvarchar(255),
        arguments nvarchar(max),
        assigned_scope nvarchar(32),
        pending_workflow nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_process_log (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        process_name nvarchar(128),
        case_id nvarchar(128),
        workflow_case_name nvarchar(450),
        launcher nvarchar(128),
        case_status nvarchar(128),
        step_name nvarchar(128),
        approval_name nvarchar(128),
        owner_name nvarchar(128),
        start_time numeric(19,0),
        end_time numeric(19,0),
        step_duration int,
        escalations int,
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_profile (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description nvarchar(1024),
        bundle_id nvarchar(32),
        disabled tinyint,
        account_type nvarchar(128),
        application nvarchar(32),
        attributes nvarchar(max),
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_profile_constraints (
       profile nvarchar(32) not null,
        idx int not null,
        elt nvarchar(max),
        primary key (profile, idx)
    );
    GO

    create table identityiq.spt_profile_permissions (
       profile nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        attributes nvarchar(max),
        primary key (profile, idx)
    );
    GO

    create table identityiq.spt_provisioning_request (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        identity_id nvarchar(32),
        target nvarchar(128),
        requester nvarchar(128),
        expiration numeric(19,0),
        provisioning_plan nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_provisioning_transaction (
       id nvarchar(32) not null,
        name nvarchar(255),
        created numeric(19,0),
        modified numeric(19,0),
        operation nvarchar(255),
        source nvarchar(255),
        application_name nvarchar(255),
        identity_name nvarchar(255),
        identity_display_name nvarchar(255),
        native_identity nvarchar(322),
        account_display_name nvarchar(322),
        attributes nvarchar(max),
        integration nvarchar(255),
        certification_id nvarchar(32),
        forced tinyint,
        type nvarchar(255),
        status nvarchar(255),
        primary key (id)
    );
    GO

    create table identityiq.spt_quick_link (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        message_key nvarchar(128),
        description nvarchar(1024),
        action nvarchar(128),
        css_class nvarchar(128),
        hidden tinyint,
        category nvarchar(128),
        ordering int,
        arguments nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_quick_link_options (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        allow_bulk tinyint,
        allow_other tinyint,
        allow_self tinyint,
        options nvarchar(max),
        dynamic_scope nvarchar(32) not null,
        quick_link nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_recommender_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_remediation_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        description nvarchar(1024),
        remediation_entity_type nvarchar(255),
        work_item_id nvarchar(32),
        certification_item nvarchar(255),
        assignee nvarchar(32),
        remediation_identity nvarchar(255),
        remediation_details nvarchar(max),
        completion_comments nvarchar(max),
        completion_date numeric(19,0),
        assimilated tinyint,
        comments nvarchar(max),
        attributes nvarchar(max),
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_remote_login_token (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        creator nvarchar(128) not null,
        remote_host nvarchar(128),
        expiration numeric(19,0),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_request (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        stack nvarchar(max),
        attributes nvarchar(max),
        launcher nvarchar(255),
        host nvarchar(255),
        launched numeric(19,0),
        progress nvarchar(255),
        percent_complete int,
        type nvarchar(255),
        messages nvarchar(max),
        completed numeric(19,0),
        expiration numeric(19,0),
        name nvarchar(450),
        phase int,
        dependent_phase int,
        next_launch numeric(19,0),
        retry_count int,
        retry_interval int,
        string1 nvarchar(2048),
        live tinyint,
        completion_status nvarchar(255),
        notification_needed tinyint,
        assigned_scope nvarchar(32),
        definition nvarchar(32),
        task_result nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_request_arguments (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        required tinyint,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_request_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(4000),
        executor nvarchar(255),
        form_path nvarchar(128),
        template tinyint,
        hidden tinyint,
        result_expiration int,
        progress_interval int,
        sub_type nvarchar(128),
        type nvarchar(255),
        progress_mode nvarchar(255),
        arguments nvarchar(max),
        retry_max int,
        retry_interval int,
        sig_description nvarchar(max),
        return_type nvarchar(255),
        assigned_scope nvarchar(32),
        parent nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_request_definition_rights (
       request_definition_id nvarchar(32) not null,
        idx int not null,
        right_id nvarchar(32) not null,
        primary key (request_definition_id, idx)
    );
    GO

    create table identityiq.spt_request_returns (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_request_state (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(450),
        attributes nvarchar(max),
        request_id nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_resource_event (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        application nvarchar(32),
        provisioning_plan nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_right_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        rights nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_role_change_event (
       id nvarchar(32) not null,
        created numeric(19,0),
        bundle_id nvarchar(128),
        bundle_name nvarchar(128),
        provisioning_plan nvarchar(max),
        bundle_deleted tinyint,
        primary key (id)
    );
    GO

    create table identityiq.spt_role_index (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        incomplete tinyint,
        composite_score int,
        attributes nvarchar(max),
        items nvarchar(max),
        bundle nvarchar(32),
        assigned_count int,
        detected_count int,
        associated_to_role tinyint,
        last_certified_membership numeric(19,0),
        last_certified_composition numeric(19,0),
        last_assigned numeric(19,0),
        entitlement_count int,
        entitlement_count_inheritance int,
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_role_metadata (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        role nvarchar(32),
        name nvarchar(255),
        additional_entitlements tinyint,
        missing_required tinyint,
        assigned tinyint,
        detected tinyint,
        detected_exception tinyint,
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_role_mining_result (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        pending tinyint,
        config nvarchar(max),
        roles nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_role_scorecard (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        role_id nvarchar(32),
        members int,
        members_extra_ent int,
        members_missing_req int,
        detected int,
        detected_exc int,
        provisioned_ent int,
        permitted_ent int,
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_rule (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        language nvarchar(255),
        source nvarchar(max),
        type nvarchar(255),
        attributes nvarchar(max),
        sig_description nvarchar(max),
        return_type nvarchar(255),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_rule_registry_callouts (
       rule_registry_id nvarchar(32) not null,
        callout nvarchar(78) not null,
        rule_id nvarchar(32) not null,
        primary key (rule_registry_id, callout)
    );
    GO

    create table identityiq.spt_rule_dependencies (
       rule_id nvarchar(32) not null,
        idx int not null,
        dependency nvarchar(32) not null,
        primary key (rule_id, idx)
    );
    GO

    create table identityiq.spt_rule_registry (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        templates nvarchar(max),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_rule_signature_arguments (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_rule_signature_returns (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_schema_attributes (
       applicationschema nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        description nvarchar(max),
        required tinyint,
        entitlement tinyint,
        is_group tinyint,
        managed tinyint,
        multi_valued tinyint,
        minable tinyint,
        indexed tinyint,
        correlation_key int,
        source nvarchar(255),
        internal_name nvarchar(255),
        default_value nvarchar(255),
        remed_mod_type nvarchar(255),
        schema_object_type nvarchar(255),
        object_mapping nvarchar(255),
        primary key (applicationschema, idx)
    );
    GO

    create table identityiq.spt_scope (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        display_name nvarchar(128),
        parent_id nvarchar(32),
        manually_created tinyint,
        dormant tinyint,
        path nvarchar(450),
        dirty tinyint,
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_scorecard (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        incomplete tinyint,
        composite_score int,
        attributes nvarchar(max),
        items nvarchar(max),
        business_role_score int,
        raw_business_role_score int,
        entitlement_score int,
        raw_entitlement_score int,
        policy_score int,
        raw_policy_score int,
        certification_score int,
        total_violations int,
        total_remediations int,
        total_delegations int,
        total_mitigations int,
        total_approvals int,
        identity_id nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_score_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        maximum_score int,
        maximum_number_of_bands int,
        application_configs nvarchar(max),
        identity_scores nvarchar(max),
        application_scores nvarchar(max),
        bands nvarchar(max),
        right_config nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_server (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        extended1 nvarchar(255),
        name nvarchar(128) not null,
        heartbeat numeric(19,0),
        inactive tinyint,
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_server_statistic (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        snapshot_name nvarchar(128),
        value nvarchar(4000),
        value_type nvarchar(128),
        host nvarchar(32),
        attributes nvarchar(max),
        target nvarchar(128),
        target_type nvarchar(128),
        monitoring_statistic nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_service_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        description nvarchar(1024),
        executor nvarchar(255),
        exec_interval int,
        hosts nvarchar(1024),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_service_status (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        description nvarchar(1024),
        definition nvarchar(32),
        host nvarchar(255),
        last_start numeric(19,0),
        last_end numeric(19,0),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_sign_off_history (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        sign_date numeric(19,0),
        signer_id nvarchar(128),
        signer_name nvarchar(128),
        signer_display_name nvarchar(128),
        application nvarchar(128),
        account nvarchar(128),
        text nvarchar(max),
        electronic_sign tinyint,
        certification_id nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_snapshot_permissions (
       snapshot nvarchar(32) not null,
        idx int not null,
        target nvarchar(255),
        rights nvarchar(4000),
        attributes nvarchar(max),
        primary key (snapshot, idx)
    );
    GO

    create table identityiq.spt_sodconstraint (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(2000),
        description nvarchar(4000),
        policy nvarchar(32),
        violation_owner_type nvarchar(255),
        violation_owner nvarchar(32),
        violation_owner_rule nvarchar(32),
        compensating_control nvarchar(max),
        disabled tinyint,
        weight int,
        remediation_advice nvarchar(max),
        violation_summary nvarchar(max),
        arguments nvarchar(max),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_sodconstraint_left (
       sodconstraint nvarchar(32) not null,
        idx int not null,
        businessrole nvarchar(32) not null,
        primary key (sodconstraint, idx)
    );
    GO

    create table identityiq.spt_sodconstraint_right (
       sodconstraint nvarchar(32) not null,
        idx int not null,
        businessrole nvarchar(32) not null,
        primary key (sodconstraint, idx)
    );
    GO

    create table identityiq.spt_archived_cert_entity (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        entity nvarchar(max),
        reason nvarchar(255),
        explanation nvarchar(max),
        certification_id nvarchar(32),
        target_name nvarchar(255),
        identity_name nvarchar(450),
        account_group nvarchar(450),
        application nvarchar(255),
        native_identity nvarchar(322),
        reference_attribute nvarchar(255),
        schema_object_type nvarchar(255),
        target_id nvarchar(255),
        target_display_name nvarchar(255),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_archived_cert_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        type nvarchar(255),
        sub_type nvarchar(255),
        item_id nvarchar(128),
        exception_application nvarchar(128),
        exception_attribute_name nvarchar(255),
        exception_attribute_value nvarchar(2048),
        exception_permission_target nvarchar(255),
        exception_permission_right nvarchar(255),
        exception_native_identity nvarchar(322),
        constraint_name nvarchar(2000),
        policy nvarchar(256),
        bundle nvarchar(255),
        violation_summary nvarchar(256),
        entitlements nvarchar(max),
        parent_id nvarchar(32),
        target_display_name nvarchar(255),
        target_name nvarchar(255),
        target_id nvarchar(255),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_identity_req_item_attach (
       identity_request_item_id nvarchar(32) not null,
        idx int not null,
        attachment_id nvarchar(32) not null,
        primary key (identity_request_item_id, idx)
    );
    GO

    create table identityiq.spt_right (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(1024),
        display_name nvarchar(128),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_sync_roles (
       config nvarchar(32) not null,
        idx int not null,
        bundle nvarchar(32) not null,
        primary key (config, idx)
    );
    GO

    create table identityiq.spt_syslog_event (
       id nvarchar(32) not null,
        created numeric(19,0),
        quick_key nvarchar(12),
        event_level nvarchar(6),
        classname nvarchar(128),
        line_number nvarchar(6),
        message nvarchar(450),
        thread nvarchar(128),
        server nvarchar(128),
        username nvarchar(128),
        stacktrace nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_tag (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        primary key (id)
    );
    GO

    create table identityiq.spt_target (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        extended1 nvarchar(255),
        name nvarchar(512),
        native_owner_id nvarchar(128),
        application nvarchar(32),
        target_host nvarchar(1024),
        display_name nvarchar(400),
        full_path nvarchar(max),
        unique_name_hash nvarchar(128),
        attributes nvarchar(max),
        native_object_id nvarchar(322),
        target_size numeric(19,0),
        last_aggregation numeric(19,0),
        target_source nvarchar(32),
        parent nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_target_association (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        object_id nvarchar(32),
        type nvarchar(8),
        hierarchy nvarchar(512),
        flattened tinyint,
        application_name nvarchar(128),
        target_type nvarchar(128),
        target_name nvarchar(255),
        target_id nvarchar(32),
        rights nvarchar(512),
        inherited tinyint,
        effective int,
        deny_permission tinyint,
        last_aggregation numeric(19,0),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_target_source (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description nvarchar(1024),
        collector nvarchar(255),
        last_refresh numeric(19,0),
        configuration nvarchar(max),
        correlation_rule nvarchar(32),
        creation_rule nvarchar(32),
        refresh_rule nvarchar(32),
        transformation_rule nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_target_sources (
       application nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (application, idx)
    );
    GO

    create table identityiq.spt_task_definition (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(4000),
        executor nvarchar(255),
        form_path nvarchar(128),
        template tinyint,
        hidden tinyint,
        result_expiration int,
        progress_interval int,
        sub_type nvarchar(128),
        type nvarchar(255),
        progress_mode nvarchar(255),
        arguments nvarchar(max),
        result_renderer nvarchar(255),
        concurrent tinyint,
        deprecated tinyint not null,
        result_action nvarchar(255),
        sig_description nvarchar(max),
        return_type nvarchar(255),
        parent nvarchar(32),
        signoff_config nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_task_definition_rights (
       task_definition_id nvarchar(32) not null,
        idx int not null,
        right_id nvarchar(32) not null,
        primary key (task_definition_id, idx)
    );
    GO

    create table identityiq.spt_task_event (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        phase nvarchar(128),
        rule_id nvarchar(32),
        attributes nvarchar(max),
        task_result nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_task_result (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        stack nvarchar(max),
        attributes nvarchar(max),
        launcher nvarchar(255),
        host nvarchar(255),
        launched numeric(19,0),
        progress nvarchar(255),
        percent_complete int,
        type nvarchar(255),
        messages nvarchar(max),
        completed numeric(19,0),
        expiration numeric(19,0),
        verified numeric(19,0),
        name nvarchar(255) not null,
        definition nvarchar(32),
        schedule nvarchar(255),
        pending_signoffs int,
        signoff nvarchar(max),
        report nvarchar(32),
        target_class nvarchar(255),
        target_id nvarchar(255),
        target_name nvarchar(255),
        task_terminated tinyint,
        partitioned tinyint,
        completion_status nvarchar(255),
        run_length int,
        run_length_average int,
        run_length_deviation int,
        primary key (id)
    );
    GO

    create table identityiq.spt_task_signature_arguments (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        help_key nvarchar(255),
        input_template nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        required tinyint,
        default_value nvarchar(255),
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_task_signature_returns (
       signature nvarchar(32) not null,
        idx int not null,
        name nvarchar(255),
        type nvarchar(255),
        filter_string nvarchar(255),
        description nvarchar(max),
        prompt nvarchar(max),
        multi tinyint,
        primary key (signature, idx)
    );
    GO

    create table identityiq.spt_time_period (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        classifier nvarchar(255),
        init_parameters nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_uiconfig (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_uipreferences (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        preferences nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_widget (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        title nvarchar(128),
        selector nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        description nvarchar(4000),
        type nvarchar(128),
        task_type nvarchar(255),
        template tinyint,
        explicit_transitions tinyint,
        monitored tinyint,
        result_expiration int,
        complete tinyint,
        handler nvarchar(128),
        work_item_renderer nvarchar(128),
        variable_definitions nvarchar(max),
        config_form nvarchar(128),
        steps nvarchar(max),
        work_item_config nvarchar(max),
        variables nvarchar(max),
        libraries nvarchar(128),
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_rule_libraries (
       rule_id nvarchar(32) not null,
        idx int not null,
        dependency nvarchar(32) not null,
        primary key (rule_id, idx)
    );
    GO

    create table identityiq.spt_workflow_case (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        stack nvarchar(max),
        attributes nvarchar(max),
        launcher nvarchar(255),
        host nvarchar(255),
        launched numeric(19,0),
        progress nvarchar(255),
        percent_complete int,
        type nvarchar(255),
        messages nvarchar(max),
        completed numeric(19,0),
        name nvarchar(450),
        description nvarchar(1024),
        complete tinyint,
        target_class nvarchar(255),
        target_id nvarchar(255),
        target_name nvarchar(255),
        workflow nvarchar(max),
        iiqlock nvarchar(128),
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_registry (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128) not null,
        types nvarchar(max),
        templates nvarchar(max),
        callables nvarchar(max),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_target (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description nvarchar(1024),
        class_name nvarchar(255),
        object_id nvarchar(255),
        object_name nvarchar(255),
        workflow_case_id nvarchar(32) not null,
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_workflow_test_suite (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        name nvarchar(128) not null,
        description nvarchar(4000),
        replicated tinyint,
        case_name nvarchar(255),
        tests nvarchar(max),
        responses nvarchar(max),
        attributes nvarchar(max),
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(255),
        description nvarchar(1024),
        handler nvarchar(255),
        renderer nvarchar(255),
        target_class nvarchar(255),
        target_id nvarchar(255),
        target_name nvarchar(255),
        type nvarchar(255),
        state nvarchar(255),
        severity nvarchar(255),
        requester nvarchar(32),
        completion_comments nvarchar(max),
        notification numeric(19,0),
        expiration numeric(19,0),
        wake_up_date numeric(19,0),
        reminders int,
        escalation_count int,
        notification_config nvarchar(max),
        workflow_case nvarchar(32),
        attributes nvarchar(max),
        owner_history nvarchar(max),
        certification nvarchar(255),
        certification_entity nvarchar(255),
        certification_item nvarchar(255),
        identity_request_id nvarchar(128),
        assignee nvarchar(32),
        iiqlock nvarchar(128),
        certification_ref_id nvarchar(32),
        idx int,
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_comments (
       work_item nvarchar(32) not null,
        idx int not null,
        author nvarchar(255),
        comments nvarchar(max),
        comment_date numeric(19,0),
        primary key (work_item, idx)
    );
    GO

    create table identityiq.spt_work_item_archive (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        work_item_id nvarchar(128),
        name nvarchar(255),
        owner_name nvarchar(255),
        identity_request_id nvarchar(128),
        assignee nvarchar(255),
        requester nvarchar(255),
        description nvarchar(1024),
        handler nvarchar(255),
        renderer nvarchar(255),
        target_class nvarchar(255),
        target_id nvarchar(255),
        target_name nvarchar(255),
        archived numeric(19,0),
        type nvarchar(255),
        state nvarchar(255),
        severity nvarchar(255),
        attributes nvarchar(max),
        system_attributes nvarchar(max),
        immutable tinyint,
        signed tinyint,
        completer nvarchar(255),
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_config (
       id nvarchar(32) not null,
        created numeric(19,0),
        modified numeric(19,0),
        owner nvarchar(32),
        assigned_scope nvarchar(32),
        assigned_scope_path nvarchar(450),
        name nvarchar(128),
        description_template nvarchar(1024),
        disabled tinyint,
        no_work_item tinyint,
        owner_rule nvarchar(32),
        hours_till_escalation int,
        hours_between_reminders int,
        max_reminders int,
        notification_email nvarchar(32),
        reminder_email nvarchar(32),
        escalation_email nvarchar(32),
        escalation_rule nvarchar(32),
        parent nvarchar(32),
        primary key (id)
    );
    GO

    create table identityiq.spt_work_item_owners (
       config nvarchar(32) not null,
        idx int not null,
        elt nvarchar(32) not null,
        primary key (config, idx)
    );
    GO
create index spt_actgroup_name_csi on identityiq.spt_account_group (name);
    GO
create index spt_actgroup_native_ci on identityiq.spt_account_group (native_identity);
    GO
create index spt_actgroup_attr on identityiq.spt_account_group (reference_attribute);
    GO
create index spt_actgroup_lastAggregation on identityiq.spt_account_group (last_target_aggregation);
    GO
create index spt_actgroup_key1_ci on identityiq.spt_account_group (key1);
    GO
create index spt_actgroup_key2_ci on identityiq.spt_account_group (key2);
    GO
create index spt_actgroup_key3_ci on identityiq.spt_account_group (key3);
    GO
create index spt_actgroup_key4_ci on identityiq.spt_account_group (key4);
    GO
create index spt_alert_extended1_ci on identityiq.spt_alert (extended1);
    GO
create index spt_alert_last_processed on identityiq.spt_alert (last_processed);
    GO
create index spt_alert_name on identityiq.spt_alert (name);
    GO

    alter table identityiq.spt_alert_definition 
       add constraint UK_p9a15ie5pfscgm3hb745wwnsm unique (name);
    GO
create index spt_app_extended1_ci on identityiq.spt_application (extended1);
    GO
create index spt_app_proxied_name on identityiq.spt_application (proxied_name);
    GO
create index spt_application_cluster on identityiq.spt_application (app_cluster);
    GO
create index spt_application_authoritative on identityiq.spt_application (authoritative);
    GO
create index spt_application_logical on identityiq.spt_application (logical);
    GO
create index spt_application_provisioning on identityiq.spt_application (supports_provisioning);
    GO
create index spt_application_authenticate on identityiq.spt_application (supports_authenticate);
    GO
create index spt_application_acct_only on identityiq.spt_application (supports_account_only);
    GO
create index spt_application_addt_acct on identityiq.spt_application (supports_additional_accounts);
    GO
create index spt_application_no_agg on identityiq.spt_application (no_aggregation);
    GO
create index spt_app_sync_provisioning on identityiq.spt_application (sync_provisioning);
    GO
create index spt_application_mgd_apps on identityiq.spt_application (manages_other_apps);
    GO

    alter table identityiq.spt_application 
       add constraint UK_ol1192j17pnj5syamkr9ecb28 unique (name);
    GO
create index app_scorecard_cscore on identityiq.spt_application_scorecard (composite_score);
    GO

    alter table identityiq.spt_audit_config 
       add constraint UK_g3dye1egpdn4t6ikmfqeohyfa unique (name);
    GO
create index spt_audit_interface_ci on identityiq.spt_audit_event (interface);
    GO
create index spt_audit_source_ci on identityiq.spt_audit_event (source);
    GO
create index spt_audit_action_ci on identityiq.spt_audit_event (action);
    GO
create index spt_audit_target_ci on identityiq.spt_audit_event (target);
    GO
create index spt_audit_application_ci on identityiq.spt_audit_event (application);
    GO
create index spt_audit_accountname_ci on identityiq.spt_audit_event (account_name);
    GO
create index spt_audit_instance_ci on identityiq.spt_audit_event (instance);
    GO
create index spt_audit_attr_ci on identityiq.spt_audit_event (attribute_name);
    GO
create index spt_audit_attrVal_ci on identityiq.spt_audit_event (attribute_value);
    GO
create index spt_audit_trackingid_ci on identityiq.spt_audit_event (tracking_id);
    GO
create index spt_bundle_extended1_ci on identityiq.spt_bundle (extended1);
    GO
create index spt_bundle_dispname_ci on identityiq.spt_bundle (displayable_name);
    GO
create index spt_bundle_disabled on identityiq.spt_bundle (disabled);
    GO
create index spt_bundle_type on identityiq.spt_bundle (type);
    GO

    alter table identityiq.spt_bundle 
       add constraint UK_smf7ppq8j0o6ijtrhh7ga9ck3 unique (name);
    GO
create index spt_bundle_archive_source on identityiq.spt_bundle_archive (source_id);
    GO

    alter table identityiq.spt_capability 
       add constraint UK_icigo0rpdnfxkqv03375j2mnv unique (name);
    GO

    alter table identityiq.spt_category 
       add constraint UK_r4nfd0896ly42tur7agn58fl6 unique (name);
    GO
create index spt_certification_name_ci on identityiq.spt_certification (name);
    GO
create index spt_cert_short_name_ci on identityiq.spt_certification (short_name);
    GO
create index spt_certification_signed on identityiq.spt_certification (signed);
    GO
create index spt_certification_finished on identityiq.spt_certification (finished);
    GO
create index spt_cert_auto_close_date on identityiq.spt_certification (automatic_closing_date);
    GO
create index spt_cert_application_ci on identityiq.spt_certification (application_id);
    GO
create index spt_cert_manager_ci on identityiq.spt_certification (manager);
    GO
create index spt_cert_group_id_ci on identityiq.spt_certification (group_definition_id);
    GO
create index spt_cert_group_name_ci on identityiq.spt_certification (group_definition_name);
    GO
create index spt_cert_percent_complete on identityiq.spt_certification (percent_complete);
    GO
create index spt_cert_type_ci on identityiq.spt_certification (type);
    GO
create index spt_cert_task_sched_id_ci on identityiq.spt_certification (task_schedule_id);
    GO
create index spt_cert_trigger_id_ci on identityiq.spt_certification (trigger_id);
    GO
create index spt_cert_cert_def_id_ci on identityiq.spt_certification (certification_definition_id);
    GO
create index spt_cert_phase_ci on identityiq.spt_certification (phase);
    GO
create index spt_cert_nxt_phs_tran on identityiq.spt_certification (next_phase_transition);
    GO
create index spt_cert_nextRemediationScan on identityiq.spt_certification (next_remediation_scan);
    GO
create index nxt_cert_req_scan on identityiq.spt_certification (next_cert_required_scan);
    GO
create index nxt_overdue_scan on identityiq.spt_certification (next_overdue_scan);
    GO
create index spt_cert_exclude_inactive on identityiq.spt_certification (exclude_inactive);
    GO
create index spt_cert_electronic_signed on identityiq.spt_certification (electronically_signed);
    GO
create index spt_item_ready_for_remed on identityiq.spt_certification_action (ready_for_remediation);
    GO
create index spt_cert_archive_id on identityiq.spt_certification_archive (certification_id);
    GO
create index spt_cert_archive_grp_id on identityiq.spt_certification_archive (certification_group_id);
    GO
create index spt_cert_archive_creator on identityiq.spt_certification_archive (creator);
    GO

    alter table identityiq.spt_certification_definition 
       add constraint UK_kayn5nry9qy90kk9e9f2e2vut unique (name);
    GO
create index spt_certification_entity_stat on identityiq.spt_certification_entity (summary_status);
    GO
create index spt_certification_entity_state on identityiq.spt_certification_entity (continuous_state);
    GO
create index spt_certification_entity_ld on identityiq.spt_certification_entity (last_decision);
    GO
create index spt_certification_entity_nsc on identityiq.spt_certification_entity (next_continuous_state_change);
    GO
create index spt_certification_entity_due on identityiq.spt_certification_entity (overdue_date);
    GO
create index spt_certification_entity_diffs on identityiq.spt_certification_entity (has_differences);
    GO
create index spt_certification_entity_tn on identityiq.spt_certification_entity (target_name);
    GO
create index spt_cert_entity_identity on identityiq.spt_certification_entity (identity_id);
    GO
create index spt_cert_entity_firstname_ci on identityiq.spt_certification_entity (firstname);
    GO
create index spt_cert_entity_lastname_ci on identityiq.spt_certification_entity (lastname);
    GO
create index spt_cert_entity_cscore on identityiq.spt_certification_entity (composite_score);
    GO
create index spt_cert_entity_new_user on identityiq.spt_certification_entity (new_user);
    GO
create index spt_cert_entity_pending on identityiq.spt_certification_entity (pending_certification);
    GO
create index spt_cert_group_type on identityiq.spt_certification_group (type);
    GO
create index spt_cert_group_status on identityiq.spt_certification_group (status);
    GO
create index spt_cert_grp_perc_comp on identityiq.spt_certification_group (percent_complete);
    GO
create index spt_certification_item_stat on identityiq.spt_certification_item (summary_status);
    GO
create index spt_certification_item_state on identityiq.spt_certification_item (continuous_state);
    GO
create index spt_certification_item_ld on identityiq.spt_certification_item (last_decision);
    GO
create index spt_certification_item_nsc on identityiq.spt_certification_item (next_continuous_state_change);
    GO
create index spt_certification_item_due on identityiq.spt_certification_item (overdue_date);
    GO
create index spt_certification_item_diffs on identityiq.spt_certification_item (has_differences);
    GO
create index spt_certification_item_tn on identityiq.spt_certification_item (target_name);
    GO
create index spt_cert_item_bundle on identityiq.spt_certification_item (bundle);
    GO
create index spt_cert_item_type on identityiq.spt_certification_item (type);
    GO
create index spt_needs_refresh on identityiq.spt_certification_item (needs_refresh);
    GO
create index spt_cert_item_exception_app on identityiq.spt_certification_item (exception_application);
    GO
create index spt_cert_item_perm_target on identityiq.spt_certification_item (exception_permission_target);
    GO
create index spt_cert_item_perm_right on identityiq.spt_certification_item (exception_permission_right);
    GO
create index spt_cert_item_wk_up on identityiq.spt_certification_item (wake_up_date);
    GO
create index spt_cert_item_phase on identityiq.spt_certification_item (phase);
    GO
create index spt_cert_item_nxt_phs_tran on identityiq.spt_certification_item (next_phase_transition);
    GO
create index spt_certitem_extended1_ci on identityiq.spt_certification_item (extended1);
    GO
create index spt_classif_dispname_ci on identityiq.spt_classification (displayable_name);
    GO

    alter table identityiq.spt_classification 
       add constraint UK_eqb3e1wxju8yopo50ljal8lpg unique (name);
    GO

    alter table identityiq.spt_configuration 
       add constraint UK_dkxlp7fgtfipuokv9qxaj735g unique (name);
    GO

    alter table identityiq.spt_correlation_config 
       add constraint UK_rwy1ty2x8aht5691cdygbjv3l unique (name);
    GO
create index spt_custom_name_csi on identityiq.spt_custom (name);
    GO
create index spt_delObj_name_ci on identityiq.spt_deleted_object (name);
    GO
create index spt_delObj_nativeIdentity_ci on identityiq.spt_deleted_object (native_identity);
    GO
create index spt_delObj_lastRefresh on identityiq.spt_deleted_object (last_refresh);
    GO
create index spt_delObj_objectType_ci on identityiq.spt_deleted_object (object_type);
    GO

    alter table identityiq.spt_dictionary_term 
       add constraint UK_js3ank2u9ao5bytbttnd249bj unique (value);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint UK_jamxxk00xqxkiw6nsww52xr2f unique (name);
    GO

    alter table identityiq.spt_email_template 
       add constraint UK_op3ic1cyo2k1owya8j156itp0 unique (name);
    GO
create index spt_ent_snap_application_ci on identityiq.spt_entitlement_snapshot (application);
    GO
create index spt_ent_snap_nativeIdentity_ci on identityiq.spt_entitlement_snapshot (native_identity);
    GO
create index spt_ent_snap_displayName_ci on identityiq.spt_entitlement_snapshot (display_name);
    GO
create index file_bucketNumber on identityiq.spt_file_bucket (file_index);
    GO

    alter table identityiq.spt_form 
       add constraint UK_8xrdket8a5q8r8c1ab5lmbarr unique (name);
    GO

    alter table identityiq.spt_full_text_index 
       add constraint UK_jc9qh3jumoqe46w0ibonmvipk unique (name);
    GO
create index group_index_cscore on identityiq.spt_group_index (composite_score);
    GO
create index spt_identity_extended1_ci on identityiq.spt_identity (extended1);
    GO
create index spt_identity_extended2_ci on identityiq.spt_identity (extended2);
    GO
create index spt_identity_extended3_ci on identityiq.spt_identity (extended3);
    GO
create index spt_identity_extended4_ci on identityiq.spt_identity (extended4);
    GO
create index spt_identity_extended5_ci on identityiq.spt_identity (extended5);
    GO
create index spt_identity_needs_refresh on identityiq.spt_identity (needs_refresh);
    GO
create index spt_identity_displayName_ci on identityiq.spt_identity (display_name);
    GO
create index spt_identity_firstname_ci on identityiq.spt_identity (firstname);
    GO
create index spt_identity_lastname_ci on identityiq.spt_identity (lastname);
    GO
create index spt_identity_email_ci on identityiq.spt_identity (email);
    GO
create index spt_identity_manager_status on identityiq.spt_identity (manager_status);
    GO
create index spt_identity_inactive on identityiq.spt_identity (inactive);
    GO
create index spt_identity_lastRefresh on identityiq.spt_identity (last_refresh);
    GO
create index spt_identity_correlated on identityiq.spt_identity (correlated);
    GO
create index spt_identity_type_ci on identityiq.spt_identity (type);
    GO
create index spt_identity_sw_version_ci on identityiq.spt_identity (software_version);
    GO
create index spt_identity_isworkgroup on identityiq.spt_identity (workgroup);
    GO

    alter table identityiq.spt_identity 
       add constraint UK_afdtg40pi16y2smshwjgj2g6h unique (name);
    GO
create index spt_identity_archive_source on identityiq.spt_identity_archive (source_id);
    GO
create index spt_identity_ent_name_ci on identityiq.spt_identity_entitlement (name);
    GO
create index spt_identity_ent_value_ci on identityiq.spt_identity_entitlement (value);
    GO
create index spt_identity_ent_nativeid_ci on identityiq.spt_identity_entitlement (native_identity);
    GO
create index spt_identity_ent_instance_ci on identityiq.spt_identity_entitlement (instance);
    GO
create index spt_identity_ent_ag_state on identityiq.spt_identity_entitlement (aggregation_state);
    GO
create index spt_identity_ent_source_ci on identityiq.spt_identity_entitlement (source);
    GO
create index spt_identity_ent_assigned on identityiq.spt_identity_entitlement (assigned);
    GO
create index spt_identity_ent_allowed on identityiq.spt_identity_entitlement (allowed);
    GO
create index spt_identity_ent_role_granted on identityiq.spt_identity_entitlement (granted_by_role);
    GO
create index spt_identity_ent_assgnid on identityiq.spt_identity_entitlement (assignment_id);
    GO
create index spt_identity_ent_type on identityiq.spt_identity_entitlement (type);
    GO
create index spt_id_hist_item_cert_type on identityiq.spt_identity_history_item (certification_type);
    GO
create index spt_id_hist_item_status on identityiq.spt_identity_history_item (status);
    GO
create index spt_id_hist_item_actor on identityiq.spt_identity_history_item (actor);
    GO
create index spt_id_hist_item_entry_date on identityiq.spt_identity_history_item (entry_date);
    GO
create index spt_id_hist_item_application on identityiq.spt_identity_history_item (application);
    GO
create index spt_id_hist_item_instance on identityiq.spt_identity_history_item (instance);
    GO
create index spt_id_hist_item_account_ci on identityiq.spt_identity_history_item (account);
    GO
create index spt_id_hist_item_ntv_id_ci on identityiq.spt_identity_history_item (native_identity);
    GO
create index spt_id_hist_item_attribute_ci on identityiq.spt_identity_history_item (attribute);
    GO
create index spt_id_hist_item_value_ci on identityiq.spt_identity_history_item (value);
    GO
create index spt_id_hist_item_policy on identityiq.spt_identity_history_item (policy);
    GO
create index spt_id_hist_item_role on identityiq.spt_identity_history_item (role);
    GO
create index spt_idrequest_name on identityiq.spt_identity_request (name);
    GO
create index spt_idrequest_state on identityiq.spt_identity_request (state);
    GO
create index spt_idrequest_type on identityiq.spt_identity_request (type);
    GO
create index spt_idrequest_target_id on identityiq.spt_identity_request (target_id);
    GO
create index spt_idrequest_target_ci on identityiq.spt_identity_request (target_display_name);
    GO
create index spt_idrequest_requestor_ci on identityiq.spt_identity_request (requester_display_name);
    GO
create index spt_idrequest_requestor_id on identityiq.spt_identity_request (requester_id);
    GO
create index spt_idrequest_endDate on identityiq.spt_identity_request (end_date);
    GO
create index spt_idrequest_verified on identityiq.spt_identity_request (verified);
    GO
create index spt_idrequest_priority on identityiq.spt_identity_request (priority);
    GO
create index spt_idrequest_compl_status on identityiq.spt_identity_request (completion_status);
    GO
create index spt_idrequest_exec_status on identityiq.spt_identity_request (execution_status);
    GO
create index spt_idrequest_has_messages on identityiq.spt_identity_request (has_messages);
    GO
create index spt_idrequest_ext_ticket_ci on identityiq.spt_identity_request (external_ticket_id);
    GO
create index spt_reqitem_name_ci on identityiq.spt_identity_request_item (name);
    GO
create index spt_reqitem_value_ci on identityiq.spt_identity_request_item (value);
    GO
create index spt_reqitem_nativeid_ci on identityiq.spt_identity_request_item (native_identity);
    GO
create index spt_reqitem_instance_ci on identityiq.spt_identity_request_item (instance);
    GO
create index spt_reqitem_ownername on identityiq.spt_identity_request_item (owner_name);
    GO
create index spt_reqitem_approvername on identityiq.spt_identity_request_item (approver_name);
    GO
create index spt_reqitem_approval_state on identityiq.spt_identity_request_item (approval_state);
    GO
create index spt_reqitem_provisioning_state on identityiq.spt_identity_request_item (provisioning_state);
    GO
create index spt_reqitem_comp_status on identityiq.spt_identity_request_item (compilation_status);
    GO
create index spt_reqitem_exp_cause on identityiq.spt_identity_request_item (expansion_cause);
    GO
create index spt_identity_id on identityiq.spt_identity_snapshot (identity_id);
    GO
create index spt_idsnap_id_name on identityiq.spt_identity_snapshot (identity_name);
    GO

    alter table identityiq.spt_integration_config 
       add constraint UK_ktnweagpbwlxvsst5icni3epm unique (name);
    GO
create index bucketNumber on identityiq.spt_jasper_page_bucket (bucket_number);
    GO
create index handlerId on identityiq.spt_jasper_page_bucket (handler_id);
    GO

    alter table identityiq.spt_jasper_template 
       add constraint UK_4sukasjpluq6bcpu1vybgn6o3 unique (name);
    GO
create index spt_link_key1_ci on identityiq.spt_link (key1);
    GO
create index spt_link_extended1_ci on identityiq.spt_link (extended1);
    GO
create index spt_link_dispname_ci on identityiq.spt_link (display_name);
    GO
create index spt_link_nativeIdentity_ci on identityiq.spt_link (native_identity);
    GO
create index spt_link_lastRefresh on identityiq.spt_link (last_refresh);
    GO
create index spt_link_lastAggregation on identityiq.spt_link (last_target_aggregation);
    GO
create index spt_link_entitlements on identityiq.spt_link (entitlements);
    GO
create index spt_localized_attr_name on identityiq.spt_localized_attribute (name);
    GO
create index spt_localized_attr_locale on identityiq.spt_localized_attribute (locale);
    GO
create index spt_localized_attr_attr on identityiq.spt_localized_attribute (attribute);
    GO
create index spt_localized_attr_targetname on identityiq.spt_localized_attribute (target_name);
    GO
create index spt_localized_attr_targetid on identityiq.spt_localized_attribute (target_id);
    GO
create index spt_managed_attr_extended1_ci on identityiq.spt_managed_attribute (extended1);
    GO
create index spt_managed_attr_extended2_ci on identityiq.spt_managed_attribute (extended2);
    GO
create index spt_managed_attr_extended3_ci on identityiq.spt_managed_attribute (extended3);
    GO
create index spt_managed_attr_type on identityiq.spt_managed_attribute (type);
    GO
create index spt_managed_attr_aggregated on identityiq.spt_managed_attribute (aggregated);
    GO
create index spt_managed_attr_attr_ci on identityiq.spt_managed_attribute (attribute);
    GO
create index spt_managed_attr_value_ci on identityiq.spt_managed_attribute (value);
    GO
create index spt_managed_attr_dispname_ci on identityiq.spt_managed_attribute (displayable_name);
    GO
create index spt_managed_attr_uuid_ci on identityiq.spt_managed_attribute (uuid);
    GO
create index spt_managed_attr_requestable on identityiq.spt_managed_attribute (requestable);
    GO
create index spt_managed_attr_last_tgt_agg on identityiq.spt_managed_attribute (last_target_aggregation);
    GO
create index spt_ma_key1_ci on identityiq.spt_managed_attribute (key1);
    GO
create index spt_ma_key2_ci on identityiq.spt_managed_attribute (key2);
    GO
create index spt_ma_key3_ci on identityiq.spt_managed_attribute (key3);
    GO
create index spt_ma_key4_ci on identityiq.spt_managed_attribute (key4);
    GO

    alter table identityiq.spt_managed_attribute 
       add constraint UK_prmbsvo2fb4pei4ff9a5m2kso unique (hash);
    GO

    alter table identityiq.spt_message_template 
       add constraint UK_husdj437loithtt5rgxwx3oqv unique (name);
    GO

    alter table identityiq.spt_mining_config 
       add constraint UK_t2qyp373evmrsowd6svdi6ljk unique (name);
    GO
create index spt_mitigation_role on identityiq.spt_mitigation_expiration (role_name);
    GO
create index spt_mitigation_policy on identityiq.spt_mitigation_expiration (policy);
    GO
create index spt_mitigation_app on identityiq.spt_mitigation_expiration (application);
    GO
create index spt_mitigation_instance on identityiq.spt_mitigation_expiration (instance);
    GO
create index spt_mitigation_account_ci on identityiq.spt_mitigation_expiration (native_identity);
    GO
create index spt_mitigation_attr_name_ci on identityiq.spt_mitigation_expiration (attribute_name);
    GO
create index spt_mitigation_attr_val_ci on identityiq.spt_mitigation_expiration (attribute_value);
    GO
create index spt_mitigation_permission on identityiq.spt_mitigation_expiration (permission);
    GO

    alter table identityiq.spt_module 
       add constraint UK_bebq8nsflsucu90sph68pf43r unique (name);
    GO

    alter table identityiq.spt_monitoring_statistic 
       add constraint UK_k7skupvvbqf88k94pd6ukh49c unique (name);
    GO
create index spt_classification_owner_id on identityiq.spt_object_classification (owner_id);
    GO
create index spt_class_owner_type on identityiq.spt_object_classification (owner_type);
    GO

    alter table identityiq.spt_object_config 
       add constraint UK_thw4nv9d2kok4jrqbcg7ume8h unique (name);
    GO
create index spt_partition_status on identityiq.spt_partition_result (completion_status);
    GO

    alter table identityiq.spt_partition_result 
       add constraint UK_9hkfjsotujyf84i2ilkevu3no unique (name);
    GO

    alter table identityiq.spt_password_policy 
       add constraint UK_ousim2j29ecrtdoppi5diwmxr unique (name);
    GO
create index spt_plugin_name_ci on identityiq.spt_plugin (name);
    GO
create index spt_plugin_dn_ci on identityiq.spt_plugin (display_name);
    GO

    alter table identityiq.spt_plugin 
       add constraint UK_c7ccr73vpnee48igqv6w9spmp unique (file_id);
    GO

    alter table identityiq.spt_policy 
       add constraint UK_lgdxftlbfwbn2c2jtptk4tkt4 unique (name);
    GO
create index spt_policy_violation_active on identityiq.spt_policy_violation (active);
    GO
create index spt_process_log_process_name on identityiq.spt_process_log (process_name);
    GO
create index spt_process_log_case_id on identityiq.spt_process_log (case_id);
    GO
create index spt_process_log_wf_case_name on identityiq.spt_process_log (workflow_case_name);
    GO
create index spt_process_log_case_status on identityiq.spt_process_log (case_status);
    GO
create index spt_process_log_step_name on identityiq.spt_process_log (step_name);
    GO
create index spt_process_log_approval_name on identityiq.spt_process_log (approval_name);
    GO
create index spt_process_log_owner_name on identityiq.spt_process_log (owner_name);
    GO
create index spt_provreq_expiration on identityiq.spt_provisioning_request (expiration);
    GO
create index spt_prvtrans_name on identityiq.spt_provisioning_transaction (name);
    GO
create index spt_prvtrans_created on identityiq.spt_provisioning_transaction (created);
    GO
create index spt_prvtrans_op on identityiq.spt_provisioning_transaction (operation);
    GO
create index spt_prvtrans_src on identityiq.spt_provisioning_transaction (source);
    GO
create index spt_prvtrans_app_ci on identityiq.spt_provisioning_transaction (application_name);
    GO
create index spt_prvtrans_idn_ci on identityiq.spt_provisioning_transaction (identity_name);
    GO
create index spt_prvtrans_iddn_ci on identityiq.spt_provisioning_transaction (identity_display_name);
    GO
create index spt_prvtrans_nid_ci on identityiq.spt_provisioning_transaction (native_identity);
    GO
create index spt_prvtrans_adn_ci on identityiq.spt_provisioning_transaction (account_display_name);
    GO
create index spt_prvtrans_integ_ci on identityiq.spt_provisioning_transaction (integration);
    GO
create index spt_prvtrans_forced on identityiq.spt_provisioning_transaction (forced);
    GO
create index spt_prvtrans_type on identityiq.spt_provisioning_transaction (type);
    GO
create index spt_prvtrans_status on identityiq.spt_provisioning_transaction (status);
    GO

    alter table identityiq.spt_quick_link 
       add constraint UK_merms3cmmi5yrruxr338mbh7d unique (name);
    GO

    alter table identityiq.spt_recommender_definition 
       add constraint UK_ekuvq6a1uhwkxb7fofir077xv unique (name);
    GO
create index spt_remote_login_expiration on identityiq.spt_remote_login_token (expiration);
    GO
create index spt_request_expiration on identityiq.spt_request (expiration);
    GO
create index spt_request_name on identityiq.spt_request (name);
    GO
create index spt_request_phase on identityiq.spt_request (phase);
    GO
create index spt_request_depPhase on identityiq.spt_request (dependent_phase);
    GO
create index spt_request_nextLaunch on identityiq.spt_request (next_launch);
    GO
create index spt_request_compl_status on identityiq.spt_request (completion_status);
    GO
create index spt_request_notif_needed on identityiq.spt_request (notification_needed);
    GO

    alter table identityiq.spt_request_definition 
       add constraint UK_3nt4yuuvbl2byvkendp3j4agv unique (name);
    GO

    alter table identityiq.spt_right_config 
       add constraint UK_kcvm6fgx3ncfka1e91frbq594 unique (name);
    GO
create index role_index_cscore on identityiq.spt_role_index (composite_score);
    GO

    alter table identityiq.spt_rule 
       add constraint UK_sy7p5bybnsqmi3odg5twi35al unique (name);
    GO

    alter table identityiq.spt_rule_registry 
       add constraint UK_rhm4bwwsb05g3kcpdyy0gajev unique (name);
    GO
create index spt_app_attr_mod on identityiq.spt_schema_attributes (remed_mod_type);
    GO
create index scope_name_ci on identityiq.spt_scope (name);
    GO
create index scope_disp_name_ci on identityiq.spt_scope (display_name);
    GO
create index scope_path on identityiq.spt_scope (path);
    GO
create index scope_dirty on identityiq.spt_scope (dirty);
    GO
create index identity_scorecard_cscore on identityiq.spt_scorecard (composite_score);
    GO

    alter table identityiq.spt_score_config 
       add constraint UK_dmwfxhf88xip0d78xe5yebuuc unique (name);
    GO
create index spt_server_extended1_ci on identityiq.spt_server (extended1);
    GO

    alter table identityiq.spt_server 
       add constraint UK_kf14wilyojkxlsph6yo46nhf8 unique (name);
    GO
create index server_stat_snapshot on identityiq.spt_server_statistic (snapshot_name);
    GO

    alter table identityiq.spt_service_definition 
       add constraint UK_62qdarwripq8h3mmibl1pg8or unique (name);
    GO

    alter table identityiq.spt_service_status 
       add constraint UK_3xrmomphbxmv4wc27d9nyk654 unique (name);
    GO
create index sign_off_history_signer_id on identityiq.spt_sign_off_history (signer_id);
    GO
create index spt_sign_off_history_esig on identityiq.spt_sign_off_history (electronic_sign);
    GO
create index spt_arch_entity_tgt_name_csi on identityiq.spt_archived_cert_entity (target_name);
    GO
create index spt_arch_entity_identity_csi on identityiq.spt_archived_cert_entity (identity_name);
    GO
create index spt_arch_entity_acct_grp_csi on identityiq.spt_archived_cert_entity (account_group);
    GO
create index spt_arch_entity_app on identityiq.spt_archived_cert_entity (application);
    GO
create index spt_arch_entity_native_id on identityiq.spt_archived_cert_entity (native_identity);
    GO
create index spt_arch_entity_ref_attr on identityiq.spt_archived_cert_entity (reference_attribute);
    GO
create index spt_arch_entity_target_id on identityiq.spt_archived_cert_entity (target_id);
    GO
create index spt_arch_entity_tgt_display on identityiq.spt_archived_cert_entity (target_display_name);
    GO
create index spt_arch_cert_item_type on identityiq.spt_archived_cert_item (type);
    GO
create index spt_arch_item_app on identityiq.spt_archived_cert_item (exception_application);
    GO
create index spt_arch_item_native_id on identityiq.spt_archived_cert_item (exception_native_identity);
    GO
create index spt_arch_item_policy on identityiq.spt_archived_cert_item (policy);
    GO
create index spt_arch_item_bundle on identityiq.spt_archived_cert_item (bundle);
    GO
create index spt_arch_cert_item_tdisplay on identityiq.spt_archived_cert_item (target_display_name);
    GO
create index spt_arch_cert_item_tname on identityiq.spt_archived_cert_item (target_name);
    GO

    alter table identityiq.spt_right 
       add constraint UK_jral3yg4vxqqx5cd3ef43p2pl unique (name);
    GO
create index spt_syslog_created on identityiq.spt_syslog_event (created);
    GO
create index spt_syslog_quickKey on identityiq.spt_syslog_event (quick_key);
    GO
create index spt_syslog_event_level on identityiq.spt_syslog_event (event_level);
    GO
create index spt_syslog_classname on identityiq.spt_syslog_event (classname);
    GO
create index spt_syslog_message on identityiq.spt_syslog_event (message);
    GO
create index spt_syslog_server on identityiq.spt_syslog_event (server);
    GO
create index spt_syslog_username on identityiq.spt_syslog_event (username);
    GO

    alter table identityiq.spt_tag 
       add constraint UK_ky9sm7nb1boucsf89s7a854p8 unique (name);
    GO
create index spt_target_extended1_ci on identityiq.spt_target (extended1);
    GO
create index spt_target_unique_name_hash on identityiq.spt_target (unique_name_hash);
    GO
create index spt_target_native_obj_id on identityiq.spt_target (native_object_id);
    GO
create index spt_target_last_agg on identityiq.spt_target (last_aggregation);
    GO
create index spt_target_assoc_id on identityiq.spt_target_association (object_id);
    GO
create index spt_target_assoc_targ_name_ci on identityiq.spt_target_association (target_name);
    GO
create index spt_target_assoc_last_agg on identityiq.spt_target_association (last_aggregation);
    GO
create index spt_task_deprecated on identityiq.spt_task_definition (deprecated);
    GO

    alter table identityiq.spt_task_definition 
       add constraint UK_ngpdc5e2vfx0bgg3onr5wwi8h unique (name);
    GO
create index spt_task_event_phase on identityiq.spt_task_event (phase);
    GO
create index spt_taskres_completed on identityiq.spt_task_result (completed);
    GO
create index spt_taskres_expiration on identityiq.spt_task_result (expiration);
    GO
create index spt_taskres_verified on identityiq.spt_task_result (verified);
    GO
create index spt_taskresult_schedule on identityiq.spt_task_result (schedule);
    GO
create index spt_taskresult_target on identityiq.spt_task_result (target_id);
    GO
create index spt_taskresult_targetname_ci on identityiq.spt_task_result (target_name);
    GO
create index spt_task_compl_status on identityiq.spt_task_result (completion_status);
    GO

    alter table identityiq.spt_task_result 
       add constraint UK_6p0er3vv16g3lmh9xw3iysskw unique (name);
    GO

    alter table identityiq.spt_uiconfig 
       add constraint UK_k68d5hs1pn9mtga8t5ff62j2b unique (name);
    GO

    alter table identityiq.spt_widget 
       add constraint UK_4by84g4xwhbk5n949cqe1f4p7 unique (name);
    GO

    alter table identityiq.spt_workflow 
       add constraint UK_1364j5ejd8rifs8f4shf0avak unique (name);
    GO
create index spt_workflowcase_target on identityiq.spt_workflow_case (target_id);
    GO

    alter table identityiq.spt_workflow_registry 
       add constraint UK_f4aqigwy74tvdfhs90l2e8mmf unique (name);
    GO

    alter table identityiq.spt_workflow_test_suite 
       add constraint UK_9db88vtedq9ehu425aarf6jxt unique (name);
    GO
create index spt_work_item_name on identityiq.spt_work_item (name);
    GO
create index spt_work_item_target on identityiq.spt_work_item (target_id);
    GO
create index spt_work_item_type on identityiq.spt_work_item (type);
    GO
create index spt_work_item_ident_req_id on identityiq.spt_work_item (identity_request_id);
    GO
create index spt_item_archive_workItemId on identityiq.spt_work_item_archive (work_item_id);
    GO
create index spt_item_archive_name on identityiq.spt_work_item_archive (name);
    GO
create index spt_item_archive_owner_ci on identityiq.spt_work_item_archive (owner_name);
    GO
create index spt_item_archive_ident_req on identityiq.spt_work_item_archive (identity_request_id);
    GO
create index spt_item_archive_assignee_ci on identityiq.spt_work_item_archive (assignee);
    GO
create index spt_item_archive_requester_ci on identityiq.spt_work_item_archive (requester);
    GO
create index spt_item_archive_target on identityiq.spt_work_item_archive (target_id);
    GO
create index spt_item_archive_type on identityiq.spt_work_item_archive (type);
    GO
create index spt_item_archive_severity on identityiq.spt_work_item_archive (severity);
    GO
create index spt_item_archive_completer on identityiq.spt_work_item_archive (completer);
    GO

    alter table identityiq.spt_account_group 
       add constraint FK81npondqko61p2jbiurtiyjjh 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK81npondqko61p2jbiurtiyjjh on identityiq.spt_account_group (owner);
    GO

    alter table identityiq.spt_account_group 
       add constraint FK34oc5rgrwidh1xfn80u7hw6ty 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK34oc5rgrwidh1xfn80u7hw6ty on identityiq.spt_account_group (assigned_scope);
    GO

    alter table identityiq.spt_account_group 
       add constraint FKr2yvl55h4eygmk9g025u7knhg 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKr2yvl55h4eygmk9g025u7knhg on identityiq.spt_account_group (application);
    GO

    alter table identityiq.spt_account_group_inheritance 
       add constraint FK37nc4s7oaae0og1ks6qawxw5v 
       foreign key (inherits_from) 
       references identityiq.spt_account_group;
    GO

    create index FK37nc4s7oaae0og1ks6qawxw5v on identityiq.spt_account_group_inheritance (inherits_from);
    GO

    alter table identityiq.spt_account_group_inheritance 
       add constraint FKmapn2o892qhdmaa1r4lemvgax 
       foreign key (account_group) 
       references identityiq.spt_account_group;
    GO

    create index FKmapn2o892qhdmaa1r4lemvgax on identityiq.spt_account_group_inheritance (account_group);
    GO

    alter table identityiq.spt_account_group_perms 
       add constraint FKiapqdfk3kcuq5jv68yxi5x7tx 
       foreign key (accountgroup) 
       references identityiq.spt_account_group;
    GO

    create index FKiapqdfk3kcuq5jv68yxi5x7tx on identityiq.spt_account_group_perms (accountgroup);
    GO

    alter table identityiq.spt_account_group_target_perms 
       add constraint FK13f1jdxrqvk98rjhyw2nsywcj 
       foreign key (accountgroup) 
       references identityiq.spt_account_group;
    GO

    create index FK13f1jdxrqvk98rjhyw2nsywcj on identityiq.spt_account_group_target_perms (accountgroup);
    GO

    alter table identityiq.spt_activity_constraint 
       add constraint FKh07lkkaqonsf23oaqaiiowgxa 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKh07lkkaqonsf23oaqaiiowgxa on identityiq.spt_activity_constraint (owner);
    GO

    alter table identityiq.spt_activity_constraint 
       add constraint FK84atg8et8jhm2q2xrbc8y3mmg 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK84atg8et8jhm2q2xrbc8y3mmg on identityiq.spt_activity_constraint (assigned_scope);
    GO

    alter table identityiq.spt_activity_constraint 
       add constraint FK54edcjc3jxlcm0n4x49vwmqbr 
       foreign key (policy) 
       references identityiq.spt_policy;
    GO

    create index FK54edcjc3jxlcm0n4x49vwmqbr on identityiq.spt_activity_constraint (policy);
    GO

    alter table identityiq.spt_activity_constraint 
       add constraint FKi1i3q8kvh4ed7e734iwrmbkqp 
       foreign key (violation_owner) 
       references identityiq.spt_identity;
    GO

    create index FKi1i3q8kvh4ed7e734iwrmbkqp on identityiq.spt_activity_constraint (violation_owner);
    GO

    alter table identityiq.spt_activity_constraint 
       add constraint FKe1iukekxihoxdeji16gk4540c 
       foreign key (violation_owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FKe1iukekxihoxdeji16gk4540c on identityiq.spt_activity_constraint (violation_owner_rule);
    GO

    alter table identityiq.spt_activity_data_source 
       add constraint FK4nyoyf6fj2n0iqv4x6hy3p5a0 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4nyoyf6fj2n0iqv4x6hy3p5a0 on identityiq.spt_activity_data_source (owner);
    GO

    alter table identityiq.spt_activity_data_source 
       add constraint FK9xs1b8n9mbigik443n155ils7 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK9xs1b8n9mbigik443n155ils7 on identityiq.spt_activity_data_source (assigned_scope);
    GO

    alter table identityiq.spt_activity_data_source 
       add constraint FKa7oof6hhnyj73cgy991qj4159 
       foreign key (correlation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKa7oof6hhnyj73cgy991qj4159 on identityiq.spt_activity_data_source (correlation_rule);
    GO

    alter table identityiq.spt_activity_data_source 
       add constraint FK4t11m9gcjjxe4uhtlkab3mkh4 
       foreign key (transformation_rule) 
       references identityiq.spt_rule;
    GO

    create index FK4t11m9gcjjxe4uhtlkab3mkh4 on identityiq.spt_activity_data_source (transformation_rule);
    GO

    alter table identityiq.spt_activity_data_source 
       add constraint FKqh1mk9ywu09wfephle51xm9j 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKqh1mk9ywu09wfephle51xm9j on identityiq.spt_activity_data_source (application);
    GO

    alter table identityiq.spt_activity_time_periods 
       add constraint FKdf7oxva0h2xktfgb8ro54gd5 
       foreign key (time_period) 
       references identityiq.spt_time_period;
    GO

    create index FKdf7oxva0h2xktfgb8ro54gd5 on identityiq.spt_activity_time_periods (time_period);
    GO

    alter table identityiq.spt_activity_time_periods 
       add constraint FKbxg0qs6lvogays6vb2niyqgjk 
       foreign key (application_activity) 
       references identityiq.spt_application_activity;
    GO

    create index FKbxg0qs6lvogays6vb2niyqgjk on identityiq.spt_activity_time_periods (application_activity);
    GO

    alter table identityiq.spt_alert 
       add constraint FKjpmc8vdbv8mso3deakv8qi5dd 
       foreign key (source) 
       references identityiq.spt_application;
    GO

    create index FKjpmc8vdbv8mso3deakv8qi5dd on identityiq.spt_alert (source);
    GO

    alter table identityiq.spt_alert_action 
       add constraint FK4kt6nnjdocmdkgcv3wgdfvfyg 
       foreign key (alert) 
       references identityiq.spt_alert;
    GO

    create index FK4kt6nnjdocmdkgcv3wgdfvfyg on identityiq.spt_alert_action (alert);
    GO

    alter table identityiq.spt_alert_definition 
       add constraint FKm2f36vhlf1u9vnf5w1rm21i0q 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKm2f36vhlf1u9vnf5w1rm21i0q on identityiq.spt_alert_definition (owner);
    GO

    alter table identityiq.spt_alert_definition 
       add constraint FK7nrecpxk2mr7mwgli5tk5kiq9 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7nrecpxk2mr7mwgli5tk5kiq9 on identityiq.spt_alert_definition (assigned_scope);
    GO

    alter table identityiq.spt_app_dependencies 
       add constraint FKg99wvor3c1wxfmvd1j1vekrk1 
       foreign key (dependency) 
       references identityiq.spt_application;
    GO

    create index FKg99wvor3c1wxfmvd1j1vekrk1 on identityiq.spt_app_dependencies (dependency);
    GO

    alter table identityiq.spt_app_dependencies 
       add constraint FKfimmxii9xcyjfmgd0489d2q61 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKfimmxii9xcyjfmgd0489d2q61 on identityiq.spt_app_dependencies (application);
    GO

    alter table identityiq.spt_application 
       add constraint FKo50q3ykyumpddcaaokonvivah 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKo50q3ykyumpddcaaokonvivah on identityiq.spt_application (owner);
    GO

    alter table identityiq.spt_application 
       add constraint FKjrqhmrsoaxkmetjcd0y3vo09r 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKjrqhmrsoaxkmetjcd0y3vo09r on identityiq.spt_application (assigned_scope);
    GO

    alter table identityiq.spt_application 
       add constraint FKr6orbi6gkpkds9hrhowsym3yy 
       foreign key (proxy) 
       references identityiq.spt_application;
    GO

    create index FKr6orbi6gkpkds9hrhowsym3yy on identityiq.spt_application (proxy);
    GO

    alter table identityiq.spt_application 
       add constraint FKo2741mu93ute68xlirxg7ysja 
       foreign key (correlation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKo2741mu93ute68xlirxg7ysja on identityiq.spt_application (correlation_rule);
    GO

    alter table identityiq.spt_application 
       add constraint FKam9m6cw3jgye54ltd2xrnk818 
       foreign key (creation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKam9m6cw3jgye54ltd2xrnk818 on identityiq.spt_application (creation_rule);
    GO

    alter table identityiq.spt_application 
       add constraint FK27agl8inv18vxa370rnhbss30 
       foreign key (manager_correlation_rule) 
       references identityiq.spt_rule;
    GO

    create index FK27agl8inv18vxa370rnhbss30 on identityiq.spt_application (manager_correlation_rule);
    GO

    alter table identityiq.spt_application 
       add constraint FKntlbgo69p5yhm3litlje9798g 
       foreign key (customization_rule) 
       references identityiq.spt_rule;
    GO

    create index FKntlbgo69p5yhm3litlje9798g on identityiq.spt_application (customization_rule);
    GO

    alter table identityiq.spt_application 
       add constraint FKinlcagndni6i9xdctdivcl2ne 
       foreign key (managed_attr_customize_rule) 
       references identityiq.spt_rule;
    GO

    create index FKinlcagndni6i9xdctdivcl2ne on identityiq.spt_application (managed_attr_customize_rule);
    GO

    alter table identityiq.spt_application 
       add constraint FKhwhrrykvnnguijemwxxd5sn8t 
       foreign key (account_correlation_config) 
       references identityiq.spt_correlation_config;
    GO

    create index FKhwhrrykvnnguijemwxxd5sn8t on identityiq.spt_application (account_correlation_config);
    GO

    alter table identityiq.spt_application 
       add constraint FKpen32pdmnkn8icwjkusye7uul 
       foreign key (scorecard) 
       references identityiq.spt_application_scorecard;
    GO

    create index FKpen32pdmnkn8icwjkusye7uul on identityiq.spt_application (scorecard);
    GO

    alter table identityiq.spt_application 
       add constraint FKbdx986tnctokxdrqw8q77s5rm 
       foreign key (target_source) 
       references identityiq.spt_target_source;
    GO

    create index FKbdx986tnctokxdrqw8q77s5rm on identityiq.spt_application (target_source);
    GO

    alter table identityiq.spt_application_remediators 
       add constraint FK362oq0bg8kyjh8a8x6b870jkx 
       foreign key (elt) 
       references identityiq.spt_identity;
    GO

    create index FK362oq0bg8kyjh8a8x6b870jkx on identityiq.spt_application_remediators (elt);
    GO

    alter table identityiq.spt_application_remediators 
       add constraint FK8csqgw7ff1rb2f1y0gtl4nbcc 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FK8csqgw7ff1rb2f1y0gtl4nbcc on identityiq.spt_application_remediators (application);
    GO

    alter table identityiq.spt_application_activity 
       add constraint FKp0r4scrot0prnyokpjxt2649j 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKp0r4scrot0prnyokpjxt2649j on identityiq.spt_application_activity (assigned_scope);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FKkd8l977v65omox0wln8f6j20u 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKkd8l977v65omox0wln8f6j20u on identityiq.spt_application_schema (owner);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FKl0g1ud8tainvo5qqgw0vsyum6 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKl0g1ud8tainvo5qqgw0vsyum6 on identityiq.spt_application_schema (assigned_scope);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FK4sj1w1c5l3xn6dl2mbfmcgq95 
       foreign key (creation_rule) 
       references identityiq.spt_rule;
    GO

    create index FK4sj1w1c5l3xn6dl2mbfmcgq95 on identityiq.spt_application_schema (creation_rule);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FKcm5n6jy4gyawyrrv3ge1e7fqc 
       foreign key (customization_rule) 
       references identityiq.spt_rule;
    GO

    create index FKcm5n6jy4gyawyrrv3ge1e7fqc on identityiq.spt_application_schema (customization_rule);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FKov3msut61m895vk42fljyh68i 
       foreign key (correlation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKov3msut61m895vk42fljyh68i on identityiq.spt_application_schema (correlation_rule);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FK78hblkspg3qrgy9uy4yh6amt2 
       foreign key (refresh_rule) 
       references identityiq.spt_rule;
    GO

    create index FK78hblkspg3qrgy9uy4yh6amt2 on identityiq.spt_application_schema (refresh_rule);
    GO

    alter table identityiq.spt_application_schema 
       add constraint FKd3sov5jd5q1tvg43bervh4isw 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKd3sov5jd5q1tvg43bervh4isw on identityiq.spt_application_schema (application);
    GO

    alter table identityiq.spt_application_scorecard 
       add constraint FKgq6j2537q2t6enu2ots2gwlug 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKgq6j2537q2t6enu2ots2gwlug on identityiq.spt_application_scorecard (owner);
    GO

    alter table identityiq.spt_application_scorecard 
       add constraint FKd25itmjnbgivvbvknkbs4dko2 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKd25itmjnbgivvbvknkbs4dko2 on identityiq.spt_application_scorecard (assigned_scope);
    GO

    alter table identityiq.spt_application_scorecard 
       add constraint FKncvny5il4loprlf8ed4vkkm5o 
       foreign key (application_id) 
       references identityiq.spt_application;
    GO

    create index FKncvny5il4loprlf8ed4vkkm5o on identityiq.spt_application_scorecard (application_id);
    GO

    alter table identityiq.spt_app_secondary_owners 
       add constraint FKre2f8vro021ipil4lgflrrx9p 
       foreign key (elt) 
       references identityiq.spt_identity;
    GO

    create index FKre2f8vro021ipil4lgflrrx9p on identityiq.spt_app_secondary_owners (elt);
    GO

    alter table identityiq.spt_app_secondary_owners 
       add constraint FK5paly2u3hu7s3cnlx9er1tcfg 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FK5paly2u3hu7s3cnlx9er1tcfg on identityiq.spt_app_secondary_owners (application);
    GO

    alter table identityiq.spt_arch_cert_item_apps 
       add constraint FKjsbh6q9006l09jd5qso3kyn33 
       foreign key (arch_cert_item_id) 
       references identityiq.spt_archived_cert_item;
    GO

    create index FKjsbh6q9006l09jd5qso3kyn33 on identityiq.spt_arch_cert_item_apps (arch_cert_item_id);
    GO

    alter table identityiq.spt_attachment 
       add constraint FKbyb94bn214vosuh3a9cr6ydi3 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKbyb94bn214vosuh3a9cr6ydi3 on identityiq.spt_attachment (owner);
    GO

    alter table identityiq.spt_attachment 
       add constraint FKn1iv5d2bgun4hh7gmnyqyl0u7 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKn1iv5d2bgun4hh7gmnyqyl0u7 on identityiq.spt_attachment (assigned_scope);
    GO

    alter table identityiq.spt_audit_config 
       add constraint FKn99ngjtt90uu0e6osp4ben0k0 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKn99ngjtt90uu0e6osp4ben0k0 on identityiq.spt_audit_config (owner);
    GO

    alter table identityiq.spt_audit_config 
       add constraint FKnbd331q7w6aqq9xs5d2wmi63u 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKnbd331q7w6aqq9xs5d2wmi63u on identityiq.spt_audit_config (assigned_scope);
    GO

    alter table identityiq.spt_audit_event 
       add constraint FKhhxtrj41bo44qrvg1d0m5ytsy 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKhhxtrj41bo44qrvg1d0m5ytsy on identityiq.spt_audit_event (owner);
    GO

    alter table identityiq.spt_audit_event 
       add constraint FK98m5i7uik1q162vtvklx4uwxy 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK98m5i7uik1q162vtvklx4uwxy on identityiq.spt_audit_event (assigned_scope);
    GO

    alter table identityiq.spt_authentication_answer 
       add constraint FKg7ahr1e8ce0qnpwy5ukybfdlc 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKg7ahr1e8ce0qnpwy5ukybfdlc on identityiq.spt_authentication_answer (owner);
    GO

    alter table identityiq.spt_authentication_answer 
       add constraint FKeadtkbftr4xwev6djc6bt0crh 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKeadtkbftr4xwev6djc6bt0crh on identityiq.spt_authentication_answer (identity_id);
    GO

    alter table identityiq.spt_authentication_answer 
       add constraint FKt1ogpk91rvbm8w1e532nocdif 
       foreign key (question_id) 
       references identityiq.spt_authentication_question;
    GO

    create index FKt1ogpk91rvbm8w1e532nocdif on identityiq.spt_authentication_answer (question_id);
    GO

    alter table identityiq.spt_authentication_question 
       add constraint FKo1do8f67g11idf1a7147kjvvi 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKo1do8f67g11idf1a7147kjvvi on identityiq.spt_authentication_question (owner);
    GO

    alter table identityiq.spt_authentication_question 
       add constraint FKhwy7jvglm1yvvhjej8npruff2 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKhwy7jvglm1yvvhjej8npruff2 on identityiq.spt_authentication_question (assigned_scope);
    GO

    alter table identityiq.spt_batch_request 
       add constraint FKkv0v31yspj4ga5o9x6pigtmbk 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKkv0v31yspj4ga5o9x6pigtmbk on identityiq.spt_batch_request (owner);
    GO

    alter table identityiq.spt_batch_request 
       add constraint FKmi63tgq6kqghkrypoin7pqh5a 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKmi63tgq6kqghkrypoin7pqh5a on identityiq.spt_batch_request (assigned_scope);
    GO

    alter table identityiq.spt_batch_request_item 
       add constraint FK4uxgxj681uaiqpw0qku9fu49p 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4uxgxj681uaiqpw0qku9fu49p on identityiq.spt_batch_request_item (owner);
    GO

    alter table identityiq.spt_batch_request_item 
       add constraint FK8utyq880cffo95ui7mxr5tok8 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK8utyq880cffo95ui7mxr5tok8 on identityiq.spt_batch_request_item (assigned_scope);
    GO

    alter table identityiq.spt_batch_request_item 
       add constraint FKocx3j2y8pqextntj6l74qvlcj 
       foreign key (batch_request_id) 
       references identityiq.spt_batch_request;
    GO

    create index FKocx3j2y8pqextntj6l74qvlcj on identityiq.spt_batch_request_item (batch_request_id);
    GO

    alter table identityiq.spt_bundle 
       add constraint FKo1g4dgf57gojmopj8cmavgxjk 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKo1g4dgf57gojmopj8cmavgxjk on identityiq.spt_bundle (owner);
    GO

    alter table identityiq.spt_bundle 
       add constraint FKbke0asxsp6fxyv9i8ax4dfis0 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKbke0asxsp6fxyv9i8ax4dfis0 on identityiq.spt_bundle (assigned_scope);
    GO

    alter table identityiq.spt_bundle 
       add constraint FKimfl4xyw45yyv2wvsq9ymploe 
       foreign key (join_rule) 
       references identityiq.spt_rule;
    GO

    create index FKimfl4xyw45yyv2wvsq9ymploe on identityiq.spt_bundle (join_rule);
    GO

    alter table identityiq.spt_bundle 
       add constraint FKg6aah205ahbj6cdnu067npuqn 
       foreign key (pending_workflow) 
       references identityiq.spt_workflow_case;
    GO

    create index FKg6aah205ahbj6cdnu067npuqn on identityiq.spt_bundle (pending_workflow);
    GO

    alter table identityiq.spt_bundle 
       add constraint FKouwy1vyabs54byfgq0md6xg98 
       foreign key (role_index) 
       references identityiq.spt_role_index;
    GO

    create index FKouwy1vyabs54byfgq0md6xg98 on identityiq.spt_bundle (role_index);
    GO

    alter table identityiq.spt_bundle 
       add constraint FK8q7rqxa31n8e4byky2su1aul7 
       foreign key (scorecard) 
       references identityiq.spt_role_scorecard;
    GO

    create index FK8q7rqxa31n8e4byky2su1aul7 on identityiq.spt_bundle (scorecard);
    GO

    alter table identityiq.spt_bundle_archive 
       add constraint FK9ikprcio0wk332m95ja8i99nm 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK9ikprcio0wk332m95ja8i99nm on identityiq.spt_bundle_archive (owner);
    GO

    alter table identityiq.spt_bundle_archive 
       add constraint FKsoj8lev1leryowpm7imnqq2g1 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKsoj8lev1leryowpm7imnqq2g1 on identityiq.spt_bundle_archive (assigned_scope);
    GO

    alter table identityiq.spt_bundle_children 
       add constraint FKb47g0894bupcgkm3ram9lepgi 
       foreign key (child) 
       references identityiq.spt_bundle;
    GO

    create index FKb47g0894bupcgkm3ram9lepgi on identityiq.spt_bundle_children (child);
    GO

    alter table identityiq.spt_bundle_children 
       add constraint FKsislghstl6iawguwrnvx76rpk 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKsislghstl6iawguwrnvx76rpk on identityiq.spt_bundle_children (bundle);
    GO

    alter table identityiq.spt_bundle_permits 
       add constraint FKi5wtu493fivl2kxblg9ei0f51 
       foreign key (child) 
       references identityiq.spt_bundle;
    GO

    create index FKi5wtu493fivl2kxblg9ei0f51 on identityiq.spt_bundle_permits (child);
    GO

    alter table identityiq.spt_bundle_permits 
       add constraint FKcclfiby5ny4jprvjkhd2wyy14 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKcclfiby5ny4jprvjkhd2wyy14 on identityiq.spt_bundle_permits (bundle);
    GO

    alter table identityiq.spt_bundle_requirements 
       add constraint FKf5ff4s6ac2kr4tdan3hoxpogn 
       foreign key (child) 
       references identityiq.spt_bundle;
    GO

    create index FKf5ff4s6ac2kr4tdan3hoxpogn on identityiq.spt_bundle_requirements (child);
    GO

    alter table identityiq.spt_bundle_requirements 
       add constraint FKmwhuhsy3pxr2qfitnua7s12rf 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKmwhuhsy3pxr2qfitnua7s12rf on identityiq.spt_bundle_requirements (bundle);
    GO

    alter table identityiq.spt_capability 
       add constraint FKfc37j2eq2ue3bkwjujokswgwv 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKfc37j2eq2ue3bkwjujokswgwv on identityiq.spt_capability (owner);
    GO

    alter table identityiq.spt_capability 
       add constraint FKhw853kl2ued70sd1fofo2fo2f 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKhw853kl2ued70sd1fofo2fo2f on identityiq.spt_capability (assigned_scope);
    GO

    alter table identityiq.spt_capability_children 
       add constraint FKcustr3gvq1r7v2dsv0635gyal 
       foreign key (child_id) 
       references identityiq.spt_capability;
    GO

    create index FKcustr3gvq1r7v2dsv0635gyal on identityiq.spt_capability_children (child_id);
    GO

    alter table identityiq.spt_capability_children 
       add constraint FKj5rdhd8hf7vrwg06pvvnewevy 
       foreign key (capability_id) 
       references identityiq.spt_capability;
    GO

    create index FKj5rdhd8hf7vrwg06pvvnewevy on identityiq.spt_capability_children (capability_id);
    GO

    alter table identityiq.spt_capability_rights 
       add constraint FK2ly05h392vp6y87sw157to4if 
       foreign key (right_id) 
       references identityiq.spt_right;
    GO

    create index FK2ly05h392vp6y87sw157to4if on identityiq.spt_capability_rights (right_id);
    GO

    alter table identityiq.spt_capability_rights 
       add constraint FK5hked97sfwstl920p4xpbj7d9 
       foreign key (capability_id) 
       references identityiq.spt_capability;
    GO

    create index FK5hked97sfwstl920p4xpbj7d9 on identityiq.spt_capability_rights (capability_id);
    GO

    alter table identityiq.spt_category 
       add constraint FK6ly2lvlw1x3co3kllh32w9it 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK6ly2lvlw1x3co3kllh32w9it on identityiq.spt_category (owner);
    GO

    alter table identityiq.spt_category 
       add constraint FKh9mqo4to3wcj85auwfd1v0vuq 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKh9mqo4to3wcj85auwfd1v0vuq on identityiq.spt_category (assigned_scope);
    GO

    alter table identityiq.spt_cert_action_assoc 
       add constraint FK7lf26b9a79fiq8ra40n6c9jox 
       foreign key (child_id) 
       references identityiq.spt_certification_action;
    GO

    create index FK7lf26b9a79fiq8ra40n6c9jox on identityiq.spt_cert_action_assoc (child_id);
    GO

    alter table identityiq.spt_cert_action_assoc 
       add constraint FKimetcxjfnxeb3uxisl0re6h7c 
       foreign key (parent_id) 
       references identityiq.spt_certification_action;
    GO

    create index FKimetcxjfnxeb3uxisl0re6h7c on identityiq.spt_cert_action_assoc (parent_id);
    GO

    alter table identityiq.spt_certification 
       add constraint FKkam40wtg536xdls5oxfov4o42 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKkam40wtg536xdls5oxfov4o42 on identityiq.spt_certification (owner);
    GO

    alter table identityiq.spt_certification 
       add constraint FKnqhv931l5n1bu20lpcqwplr6x 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKnqhv931l5n1bu20lpcqwplr6x on identityiq.spt_certification (assigned_scope);
    GO

    alter table identityiq.spt_certification 
       add constraint FKawqph0q6n3ikiqhhytcm8dnbe 
       foreign key (parent) 
       references identityiq.spt_certification;
    GO

    create index FKawqph0q6n3ikiqhhytcm8dnbe on identityiq.spt_certification (parent);
    GO

    alter table identityiq.spt_certification_def_tags 
       add constraint FKiqp17o6qbtywuq5xa0i7ftbdq 
       foreign key (elt) 
       references identityiq.spt_tag;
    GO

    create index FKiqp17o6qbtywuq5xa0i7ftbdq on identityiq.spt_certification_def_tags (elt);
    GO

    alter table identityiq.spt_certification_def_tags 
       add constraint FK874kcq4p7hyw2ai9h2ctm1olh 
       foreign key (cert_def_id) 
       references identityiq.spt_certification_definition;
    GO

    create index FK874kcq4p7hyw2ai9h2ctm1olh on identityiq.spt_certification_def_tags (cert_def_id);
    GO

    alter table identityiq.spt_certification_groups 
       add constraint FKex7xpxslou4ye7adrputklihy 
       foreign key (group_id) 
       references identityiq.spt_certification_group;
    GO

    create index FKex7xpxslou4ye7adrputklihy on identityiq.spt_certification_groups (group_id);
    GO

    alter table identityiq.spt_certification_groups 
       add constraint FKil0cc1sbmueu7oiptxr3j62px 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FKil0cc1sbmueu7oiptxr3j62px on identityiq.spt_certification_groups (certification_id);
    GO

    alter table identityiq.spt_certification_tags 
       add constraint FK841eyy68p6495npv6dwpi04j0 
       foreign key (elt) 
       references identityiq.spt_tag;
    GO

    create index FK841eyy68p6495npv6dwpi04j0 on identityiq.spt_certification_tags (elt);
    GO

    alter table identityiq.spt_certification_tags 
       add constraint FKgpbsjaoc1wocq3euppijv9p15 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FKgpbsjaoc1wocq3euppijv9p15 on identityiq.spt_certification_tags (certification_id);
    GO

    alter table identityiq.spt_certification_action 
       add constraint FKi48dvgroqefpxtfa7pweh6o8b 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKi48dvgroqefpxtfa7pweh6o8b on identityiq.spt_certification_action (owner);
    GO

    alter table identityiq.spt_certification_action 
       add constraint FK6vi46tjqxbjj146o4o2g4nyfs 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK6vi46tjqxbjj146o4o2g4nyfs on identityiq.spt_certification_action (assigned_scope);
    GO

    alter table identityiq.spt_certification_action 
       add constraint FKqfesh5gjixog7vmn3smfijoij 
       foreign key (source_action) 
       references identityiq.spt_certification_action;
    GO

    create index FKqfesh5gjixog7vmn3smfijoij on identityiq.spt_certification_action (source_action);
    GO

    alter table identityiq.spt_certification_archive 
       add constraint FK1hkx6vis9eb73wy7c4pc1b8vf 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK1hkx6vis9eb73wy7c4pc1b8vf on identityiq.spt_certification_archive (owner);
    GO

    alter table identityiq.spt_certification_archive 
       add constraint FK7mfm8h2b8nn9atr7qh5qly4l5 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7mfm8h2b8nn9atr7qh5qly4l5 on identityiq.spt_certification_archive (assigned_scope);
    GO

    alter table identityiq.spt_certification_challenge 
       add constraint FKf7hyeykya823607fv2qvgdloe 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKf7hyeykya823607fv2qvgdloe on identityiq.spt_certification_challenge (owner);
    GO

    alter table identityiq.spt_certification_challenge 
       add constraint FK22gq5pf504r23jw4knwce7xs5 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK22gq5pf504r23jw4knwce7xs5 on identityiq.spt_certification_challenge (assigned_scope);
    GO

    alter table identityiq.spt_certification_definition 
       add constraint FKcr18syune0mkqk7ixr4jth5le 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKcr18syune0mkqk7ixr4jth5le on identityiq.spt_certification_definition (owner);
    GO

    alter table identityiq.spt_certification_definition 
       add constraint FKgd080tua8dkp274bq1wapbb1a 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKgd080tua8dkp274bq1wapbb1a on identityiq.spt_certification_definition (assigned_scope);
    GO

    alter table identityiq.spt_certification_delegation 
       add constraint FK23qqsi30cp25uv1am5yurcq0j 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK23qqsi30cp25uv1am5yurcq0j on identityiq.spt_certification_delegation (owner);
    GO

    alter table identityiq.spt_certification_delegation 
       add constraint FKgxejqcvofo95foucj5vg4u3qs 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKgxejqcvofo95foucj5vg4u3qs on identityiq.spt_certification_delegation (assigned_scope);
    GO

    alter table identityiq.spt_certification_entity 
       add constraint FKip367cn9lac3qe96fw0ccljd1 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FKip367cn9lac3qe96fw0ccljd1 on identityiq.spt_certification_entity (certification_id);
    GO

    alter table identityiq.spt_certification_entity 
       add constraint FK_8ldyhh9o0vcq3n294rbfjs415 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK_8ldyhh9o0vcq3n294rbfjs415 on identityiq.spt_certification_entity (owner);
    GO

    alter table identityiq.spt_certification_entity 
       add constraint FK_94kwlqdf1rlbuj6l25e71dg6c 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK_94kwlqdf1rlbuj6l25e71dg6c on identityiq.spt_certification_entity (assigned_scope);
    GO

    alter table identityiq.spt_certification_entity 
       add constraint FK_4kgyc7xxjq27248f3cpe2hhu 
       foreign key (action) 
       references identityiq.spt_certification_action;
    GO

    create index FK_4kgyc7xxjq27248f3cpe2hhu on identityiq.spt_certification_entity (action);
    GO

    alter table identityiq.spt_certification_entity 
       add constraint FK_hyixy5s22roljj5pk6ir6xd2p 
       foreign key (delegation) 
       references identityiq.spt_certification_delegation;
    GO

    create index FK_hyixy5s22roljj5pk6ir6xd2p on identityiq.spt_certification_entity (delegation);
    GO

    alter table identityiq.spt_certification_group 
       add constraint FKlhja2iwhg5a62sq6f1buj2axo 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKlhja2iwhg5a62sq6f1buj2axo on identityiq.spt_certification_group (owner);
    GO

    alter table identityiq.spt_certification_group 
       add constraint FKqkcuv3m20nm9bgj5lp1f0pvae 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKqkcuv3m20nm9bgj5lp1f0pvae on identityiq.spt_certification_group (assigned_scope);
    GO

    alter table identityiq.spt_certification_group 
       add constraint FKkekr0ucddvo7a8l6gcrccuudg 
       foreign key (certification_definition) 
       references identityiq.spt_certification_definition;
    GO

    create index FKkekr0ucddvo7a8l6gcrccuudg on identityiq.spt_certification_group (certification_definition);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FKlge6i5dbsbcsnxg6elephhq18 
       foreign key (certification_entity_id) 
       references identityiq.spt_certification_entity;
    GO

    create index FKlge6i5dbsbcsnxg6elephhq18 on identityiq.spt_certification_item (certification_entity_id);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FKnwb5vj6hwftfgtl9f283rvsfg 
       foreign key (exception_entitlements) 
       references identityiq.spt_entitlement_snapshot;
    GO

    create index FKnwb5vj6hwftfgtl9f283rvsfg on identityiq.spt_certification_item (exception_entitlements);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FKns942qq8bd2upr6b66wbaiekj 
       foreign key (challenge) 
       references identityiq.spt_certification_challenge;
    GO

    create index FKns942qq8bd2upr6b66wbaiekj on identityiq.spt_certification_item (challenge);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FK_2bwhd2rbxp1nvs39jxf4dothm 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK_2bwhd2rbxp1nvs39jxf4dothm on identityiq.spt_certification_item (owner);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FK_183ktprgvdwfefivf1699hd02 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK_183ktprgvdwfefivf1699hd02 on identityiq.spt_certification_item (assigned_scope);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FK_sqwuid379j4nfp6ykmbacjrk 
       foreign key (action) 
       references identityiq.spt_certification_action;
    GO

    create index FK_sqwuid379j4nfp6ykmbacjrk on identityiq.spt_certification_item (action);
    GO

    alter table identityiq.spt_certification_item 
       add constraint FK_1w71laay1l62qeujievv5l3gg 
       foreign key (delegation) 
       references identityiq.spt_certification_delegation;
    GO

    create index FK_1w71laay1l62qeujievv5l3gg on identityiq.spt_certification_item (delegation);
    GO

    alter table identityiq.spt_certifiers 
       add constraint FKq2kybcv1awb6cte2q45gkupei 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FKq2kybcv1awb6cte2q45gkupei on identityiq.spt_certifiers (certification_id);
    GO

    alter table identityiq.spt_cert_item_applications 
       add constraint FKmgki0koeep17cgfpir44de6mj 
       foreign key (certification_item_id) 
       references identityiq.spt_certification_item;
    GO

    create index FKmgki0koeep17cgfpir44de6mj on identityiq.spt_cert_item_applications (certification_item_id);
    GO

    alter table identityiq.spt_cert_item_classifications 
       add constraint FK9dehgtst8bbi31palx2ygp8hi 
       foreign key (certification_item) 
       references identityiq.spt_certification_item;
    GO

    create index FK9dehgtst8bbi31palx2ygp8hi on identityiq.spt_cert_item_classifications (certification_item);
    GO

    alter table identityiq.spt_child_certification_ids 
       add constraint FK9syrav59593wgi39hrnt8kgk5 
       foreign key (certification_archive_id) 
       references identityiq.spt_certification_archive;
    GO

    create index FK9syrav59593wgi39hrnt8kgk5 on identityiq.spt_child_certification_ids (certification_archive_id);
    GO

    alter table identityiq.spt_configuration 
       add constraint FKhjkwvbp3m63yllk6lbo4bqro7 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKhjkwvbp3m63yllk6lbo4bqro7 on identityiq.spt_configuration (owner);
    GO

    alter table identityiq.spt_configuration 
       add constraint FKp90cf11ijtygd9hxlgyo0psaa 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKp90cf11ijtygd9hxlgyo0psaa on identityiq.spt_configuration (assigned_scope);
    GO

    alter table identityiq.spt_correlation_config 
       add constraint FK8e7jfdj8slsjmmtl9saxefuep 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK8e7jfdj8slsjmmtl9saxefuep on identityiq.spt_correlation_config (owner);
    GO

    alter table identityiq.spt_correlation_config 
       add constraint FKrguogs2r8ljaxdto8u4h3e9tk 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKrguogs2r8ljaxdto8u4h3e9tk on identityiq.spt_correlation_config (assigned_scope);
    GO

    alter table identityiq.spt_custom 
       add constraint FKn2tjdgfk4rvy3vosf1v3kac2t 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKn2tjdgfk4rvy3vosf1v3kac2t on identityiq.spt_custom (owner);
    GO

    alter table identityiq.spt_custom 
       add constraint FKlkx2x8fdy1rwhtnntacydwmek 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKlkx2x8fdy1rwhtnntacydwmek on identityiq.spt_custom (assigned_scope);
    GO

    alter table identityiq.spt_deleted_object 
       add constraint FK18xcbn9moxo06bcfyg6l7ggcy 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK18xcbn9moxo06bcfyg6l7ggcy on identityiq.spt_deleted_object (owner);
    GO

    alter table identityiq.spt_deleted_object 
       add constraint FK187408eyxdoomujowu44neqde 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK187408eyxdoomujowu44neqde on identityiq.spt_deleted_object (assigned_scope);
    GO

    alter table identityiq.spt_deleted_object 
       add constraint FKe7dmgcmhkb13omi8dkh2ig89f 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKe7dmgcmhkb13omi8dkh2ig89f on identityiq.spt_deleted_object (application);
    GO

    alter table identityiq.spt_dictionary 
       add constraint FKauca1novn79fd19aug3bjsqya 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKauca1novn79fd19aug3bjsqya on identityiq.spt_dictionary (owner);
    GO

    alter table identityiq.spt_dictionary 
       add constraint FK7kdy9g1knlowpv3v4rtn7w1py 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7kdy9g1knlowpv3v4rtn7w1py on identityiq.spt_dictionary (assigned_scope);
    GO

    alter table identityiq.spt_dictionary_term 
       add constraint FKcyplq38o2e3ajj515xs3vfrf3 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKcyplq38o2e3ajj515xs3vfrf3 on identityiq.spt_dictionary_term (owner);
    GO

    alter table identityiq.spt_dictionary_term 
       add constraint FK1lnmjjwf7i80cupehvm066hdf 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK1lnmjjwf7i80cupehvm066hdf on identityiq.spt_dictionary_term (assigned_scope);
    GO

    alter table identityiq.spt_dictionary_term 
       add constraint FKrtfr7u5wa0hngye2pixfgfjtq 
       foreign key (dictionary_id) 
       references identityiq.spt_dictionary;
    GO

    create index FKrtfr7u5wa0hngye2pixfgfjtq on identityiq.spt_dictionary_term (dictionary_id);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKibw7yhehyvo75yf2gqp4nj5iq 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKibw7yhehyvo75yf2gqp4nj5iq on identityiq.spt_dynamic_scope (owner);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKpygxoi3poo3klc46c5o72qe48 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKpygxoi3poo3klc46c5o72qe48 on identityiq.spt_dynamic_scope (assigned_scope);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FK1v3xd4m55jijgosuof9e6glj8 
       foreign key (role_request_control) 
       references identityiq.spt_rule;
    GO

    create index FK1v3xd4m55jijgosuof9e6glj8 on identityiq.spt_dynamic_scope (role_request_control);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKcv5id4r7gnsso13xjubxaqnkp 
       foreign key (application_request_control) 
       references identityiq.spt_rule;
    GO

    create index FKcv5id4r7gnsso13xjubxaqnkp on identityiq.spt_dynamic_scope (application_request_control);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKktwyfv8gvs56q5ilfuguki5l5 
       foreign key (managed_attr_request_control) 
       references identityiq.spt_rule;
    GO

    create index FKktwyfv8gvs56q5ilfuguki5l5 on identityiq.spt_dynamic_scope (managed_attr_request_control);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKtktdhh12wn2ah31yrges9oiu1 
       foreign key (role_remove_control) 
       references identityiq.spt_rule;
    GO

    create index FKtktdhh12wn2ah31yrges9oiu1 on identityiq.spt_dynamic_scope (role_remove_control);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FKexhlawv29rux6bct75f19h91v 
       foreign key (application_remove_control) 
       references identityiq.spt_rule;
    GO

    create index FKexhlawv29rux6bct75f19h91v on identityiq.spt_dynamic_scope (application_remove_control);
    GO

    alter table identityiq.spt_dynamic_scope 
       add constraint FK5qib64c7xdiovhut2k81054iu 
       foreign key (managed_attr_remove_control) 
       references identityiq.spt_rule;
    GO

    create index FK5qib64c7xdiovhut2k81054iu on identityiq.spt_dynamic_scope (managed_attr_remove_control);
    GO

    alter table identityiq.spt_dynamic_scope_exclusions 
       add constraint FKrmu2wy5qkgpggwyvtlssi5ehk 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKrmu2wy5qkgpggwyvtlssi5ehk on identityiq.spt_dynamic_scope_exclusions (identity_id);
    GO

    alter table identityiq.spt_dynamic_scope_exclusions 
       add constraint FK6y9ox5g2qxpgjp2jp69qqsj1g 
       foreign key (dynamic_scope_id) 
       references identityiq.spt_dynamic_scope;
    GO

    create index FK6y9ox5g2qxpgjp2jp69qqsj1g on identityiq.spt_dynamic_scope_exclusions (dynamic_scope_id);
    GO

    alter table identityiq.spt_dynamic_scope_inclusions 
       add constraint FK3ggbccvk2ambqjdw8iynyt965 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FK3ggbccvk2ambqjdw8iynyt965 on identityiq.spt_dynamic_scope_inclusions (identity_id);
    GO

    alter table identityiq.spt_dynamic_scope_inclusions 
       add constraint FKol4cq5u3jcqik19amte10slgr 
       foreign key (dynamic_scope_id) 
       references identityiq.spt_dynamic_scope;
    GO

    create index FKol4cq5u3jcqik19amte10slgr on identityiq.spt_dynamic_scope_inclusions (dynamic_scope_id);
    GO

    alter table identityiq.spt_email_template 
       add constraint FKbgbd2hiyxohe6mp0wks9w7i6m 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKbgbd2hiyxohe6mp0wks9w7i6m on identityiq.spt_email_template (owner);
    GO

    alter table identityiq.spt_email_template 
       add constraint FKnn3hbn1pd7e492186rskdwd3c 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKnn3hbn1pd7e492186rskdwd3c on identityiq.spt_email_template (assigned_scope);
    GO

    alter table identityiq.spt_email_template_properties 
       add constraint emailtemplateproperties 
       foreign key (id) 
       references identityiq.spt_email_template;
    GO

    alter table identityiq.spt_entitlement_group 
       add constraint FKhejppx2y8jb7gn2f5kow3rd4s 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKhejppx2y8jb7gn2f5kow3rd4s on identityiq.spt_entitlement_group (owner);
    GO

    alter table identityiq.spt_entitlement_group 
       add constraint FKtckmuosehsos4esc6e7aw96x2 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKtckmuosehsos4esc6e7aw96x2 on identityiq.spt_entitlement_group (assigned_scope);
    GO

    alter table identityiq.spt_entitlement_group 
       add constraint FKkgvp9pnx75witsnhfhmi2j3e 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKkgvp9pnx75witsnhfhmi2j3e on identityiq.spt_entitlement_group (application);
    GO

    alter table identityiq.spt_entitlement_group 
       add constraint FK2r4pe9yr6ieul6o7j3gbh4ek4 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FK2r4pe9yr6ieul6o7j3gbh4ek4 on identityiq.spt_entitlement_group (identity_id);
    GO

    alter table identityiq.spt_entitlement_snapshot 
       add constraint FKg28gich6xc717ufitfs9b7ho8 
       foreign key (certification_item_id) 
       references identityiq.spt_certification_item;
    GO

    create index FKg28gich6xc717ufitfs9b7ho8 on identityiq.spt_entitlement_snapshot (certification_item_id);
    GO

    alter table identityiq.spt_file_bucket 
       add constraint FK4j1imfpmt238fhglhfh95rrs8 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4j1imfpmt238fhglhfh95rrs8 on identityiq.spt_file_bucket (owner);
    GO

    alter table identityiq.spt_file_bucket 
       add constraint FKaw7g3a6la8gky8coehtta2u32 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKaw7g3a6la8gky8coehtta2u32 on identityiq.spt_file_bucket (assigned_scope);
    GO

    alter table identityiq.spt_file_bucket 
       add constraint FK59ymu1g5ld3l6j97mx7uq0jfb 
       foreign key (parent_id) 
       references identityiq.spt_persisted_file;
    GO

    create index FK59ymu1g5ld3l6j97mx7uq0jfb on identityiq.spt_file_bucket (parent_id);
    GO

    alter table identityiq.spt_form 
       add constraint FKblc1wv6n85ie3ajioskbhtb87 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKblc1wv6n85ie3ajioskbhtb87 on identityiq.spt_form (owner);
    GO

    alter table identityiq.spt_form 
       add constraint FK7j84f82idyeb2pu1giatg6b00 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7j84f82idyeb2pu1giatg6b00 on identityiq.spt_form (assigned_scope);
    GO

    alter table identityiq.spt_form 
       add constraint FKrwbs6jyeoe0f24q9u878kktna 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKrwbs6jyeoe0f24q9u878kktna on identityiq.spt_form (application);
    GO

    alter table identityiq.spt_generic_constraint 
       add constraint FK2vhfe3qafdd3ok28mm1h90om9 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK2vhfe3qafdd3ok28mm1h90om9 on identityiq.spt_generic_constraint (owner);
    GO

    alter table identityiq.spt_generic_constraint 
       add constraint FKi7nk6nu4vkvasene3f14mnykm 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKi7nk6nu4vkvasene3f14mnykm on identityiq.spt_generic_constraint (assigned_scope);
    GO

    alter table identityiq.spt_generic_constraint 
       add constraint FKkthxi9af57y8xjm6pps9h8lr4 
       foreign key (policy) 
       references identityiq.spt_policy;
    GO

    create index FKkthxi9af57y8xjm6pps9h8lr4 on identityiq.spt_generic_constraint (policy);
    GO

    alter table identityiq.spt_generic_constraint 
       add constraint FKedawydx5t9h0xmnps51w6krpb 
       foreign key (violation_owner) 
       references identityiq.spt_identity;
    GO

    create index FKedawydx5t9h0xmnps51w6krpb on identityiq.spt_generic_constraint (violation_owner);
    GO

    alter table identityiq.spt_generic_constraint 
       add constraint FK6oqb9qqui7wajajasxflcfcnb 
       foreign key (violation_owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FK6oqb9qqui7wajajasxflcfcnb on identityiq.spt_generic_constraint (violation_owner_rule);
    GO

    alter table identityiq.spt_group_definition 
       add constraint FKku7t8vcce9maxmpgh025h8rpm 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKku7t8vcce9maxmpgh025h8rpm on identityiq.spt_group_definition (owner);
    GO

    alter table identityiq.spt_group_definition 
       add constraint FKgpkyterj8orw9ue1ecnaxcxac 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKgpkyterj8orw9ue1ecnaxcxac on identityiq.spt_group_definition (assigned_scope);
    GO

    alter table identityiq.spt_group_definition 
       add constraint FKsswaiwl9wgq1x7x66w7dw73sr 
       foreign key (factory) 
       references identityiq.spt_group_factory;
    GO

    create index FKsswaiwl9wgq1x7x66w7dw73sr on identityiq.spt_group_definition (factory);
    GO

    alter table identityiq.spt_group_definition 
       add constraint FKhxm0nnx7gf472ykocqgl9yxne 
       foreign key (group_index) 
       references identityiq.spt_group_index;
    GO

    create index FKhxm0nnx7gf472ykocqgl9yxne on identityiq.spt_group_definition (group_index);
    GO

    alter table identityiq.spt_group_factory 
       add constraint FKh274opn41khwnbi0yj2n37ftm 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKh274opn41khwnbi0yj2n37ftm on identityiq.spt_group_factory (owner);
    GO

    alter table identityiq.spt_group_factory 
       add constraint FK4l56xl5r807s9o9clecfa83sp 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK4l56xl5r807s9o9clecfa83sp on identityiq.spt_group_factory (assigned_scope);
    GO

    alter table identityiq.spt_group_factory 
       add constraint FKhbdh4oyxsx9mqfsnvk57vqotk 
       foreign key (group_owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FKhbdh4oyxsx9mqfsnvk57vqotk on identityiq.spt_group_factory (group_owner_rule);
    GO

    alter table identityiq.spt_group_index 
       add constraint FKf94ksv2vpcmefy7dtedsr4d8i 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKf94ksv2vpcmefy7dtedsr4d8i on identityiq.spt_group_index (owner);
    GO

    alter table identityiq.spt_group_index 
       add constraint FKqvs2uruibvlbl9he3319jiy67 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKqvs2uruibvlbl9he3319jiy67 on identityiq.spt_group_index (assigned_scope);
    GO

    alter table identityiq.spt_group_index 
       add constraint FKk8c1wd9ht5mtgdkgr6w2pwx07 
       foreign key (definition) 
       references identityiq.spt_group_definition;
    GO

    create index FKk8c1wd9ht5mtgdkgr6w2pwx07 on identityiq.spt_group_index (definition);
    GO

    alter table identityiq.spt_group_permissions 
       add constraint FKcratih77tg9y9028xrpsiy0x5 
       foreign key (entitlement_group_id) 
       references identityiq.spt_entitlement_group;
    GO

    create index FKcratih77tg9y9028xrpsiy0x5 on identityiq.spt_group_permissions (entitlement_group_id);
    GO

    alter table identityiq.spt_identity 
       add constraint FKdco8at7cn3mnhjf6xaahalooj 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKdco8at7cn3mnhjf6xaahalooj on identityiq.spt_identity (owner);
    GO

    alter table identityiq.spt_identity 
       add constraint FKikbm1x7vdijclac4vu15u5ovv 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKikbm1x7vdijclac4vu15u5ovv on identityiq.spt_identity (assigned_scope);
    GO

    alter table identityiq.spt_identity 
       add constraint FKoq0aevty64ohgu1m3y5n2odfb 
       foreign key (extended_identity1) 
       references identityiq.spt_identity;
    GO

    create index FKoq0aevty64ohgu1m3y5n2odfb on identityiq.spt_identity (extended_identity1);
    GO

    alter table identityiq.spt_identity 
       add constraint FKkpuohy1m4u7hhicokkoixnh3v 
       foreign key (extended_identity2) 
       references identityiq.spt_identity;
    GO

    create index FKkpuohy1m4u7hhicokkoixnh3v on identityiq.spt_identity (extended_identity2);
    GO

    alter table identityiq.spt_identity 
       add constraint FK6yjqfgtb1teavu30xemwke50h 
       foreign key (extended_identity3) 
       references identityiq.spt_identity;
    GO

    create index FK6yjqfgtb1teavu30xemwke50h on identityiq.spt_identity (extended_identity3);
    GO

    alter table identityiq.spt_identity 
       add constraint FK996is5ceoc7ssc7n0cfgavp1n 
       foreign key (extended_identity4) 
       references identityiq.spt_identity;
    GO

    create index FK996is5ceoc7ssc7n0cfgavp1n on identityiq.spt_identity (extended_identity4);
    GO

    alter table identityiq.spt_identity 
       add constraint FKl62tfosnxhkn8al4i5m098g6l 
       foreign key (extended_identity5) 
       references identityiq.spt_identity;
    GO

    create index FKl62tfosnxhkn8al4i5m098g6l on identityiq.spt_identity (extended_identity5);
    GO

    alter table identityiq.spt_identity 
       add constraint FK7l1j3c1e9yne2d7ercls5w169 
       foreign key (manager) 
       references identityiq.spt_identity;
    GO

    create index FK7l1j3c1e9yne2d7ercls5w169 on identityiq.spt_identity (manager);
    GO

    alter table identityiq.spt_identity 
       add constraint FK6erec9yefdkhc6gj4g6wpufv9 
       foreign key (administrator) 
       references identityiq.spt_identity;
    GO

    create index FK6erec9yefdkhc6gj4g6wpufv9 on identityiq.spt_identity (administrator);
    GO

    alter table identityiq.spt_identity 
       add constraint FK8ro3qhcvypwaofa3yrnal3fsi 
       foreign key (scorecard) 
       references identityiq.spt_scorecard;
    GO

    create index FK8ro3qhcvypwaofa3yrnal3fsi on identityiq.spt_identity (scorecard);
    GO

    alter table identityiq.spt_identity 
       add constraint FKaw4ye4m198dibbj2atxjg85m7 
       foreign key (uipreferences) 
       references identityiq.spt_uipreferences;
    GO

    create index FKaw4ye4m198dibbj2atxjg85m7 on identityiq.spt_identity (uipreferences);
    GO

    alter table identityiq.spt_identity_archive 
       add constraint FKp8j75f2pk9xvqyimweu32w6f8 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKp8j75f2pk9xvqyimweu32w6f8 on identityiq.spt_identity_archive (owner);
    GO

    alter table identityiq.spt_identity_archive 
       add constraint FKmridtwmjtph1265lllya9w2mn 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKmridtwmjtph1265lllya9w2mn on identityiq.spt_identity_archive (assigned_scope);
    GO

    alter table identityiq.spt_identity_assigned_roles 
       add constraint FKheohgr0xuxklx9sfhjde58ig9 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKheohgr0xuxklx9sfhjde58ig9 on identityiq.spt_identity_assigned_roles (bundle);
    GO

    alter table identityiq.spt_identity_assigned_roles 
       add constraint FKf367abg77497pwgtr61co5mc 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKf367abg77497pwgtr61co5mc on identityiq.spt_identity_assigned_roles (identity_id);
    GO

    alter table identityiq.spt_identity_bundles 
       add constraint FKmr5pwrd4ysq4uiy970s0gpija 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKmr5pwrd4ysq4uiy970s0gpija on identityiq.spt_identity_bundles (bundle);
    GO

    alter table identityiq.spt_identity_bundles 
       add constraint FKcuq8yi3rh1dxbbr7nt33io0h4 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKcuq8yi3rh1dxbbr7nt33io0h4 on identityiq.spt_identity_bundles (identity_id);
    GO

    alter table identityiq.spt_identity_capabilities 
       add constraint FK8rvftn57xdt7vtg3oe2i3bn7i 
       foreign key (capability_id) 
       references identityiq.spt_capability;
    GO

    create index FK8rvftn57xdt7vtg3oe2i3bn7i on identityiq.spt_identity_capabilities (capability_id);
    GO

    alter table identityiq.spt_identity_capabilities 
       add constraint FKe9bo37xbckkaq2k85omvmo9ld 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKe9bo37xbckkaq2k85omvmo9ld on identityiq.spt_identity_capabilities (identity_id);
    GO

    alter table identityiq.spt_identity_controlled_scopes 
       add constraint FKoahj6hw5kk9163bfes49lvasv 
       foreign key (scope_id) 
       references identityiq.spt_scope;
    GO

    create index FKoahj6hw5kk9163bfes49lvasv on identityiq.spt_identity_controlled_scopes (scope_id);
    GO

    alter table identityiq.spt_identity_controlled_scopes 
       add constraint FKqjnmhlsld4pvlix9kbrvlmsb1 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKqjnmhlsld4pvlix9kbrvlmsb1 on identityiq.spt_identity_controlled_scopes (identity_id);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FKlnoli5e2k3cofry0kh5lqwvk2 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKlnoli5e2k3cofry0kh5lqwvk2 on identityiq.spt_identity_entitlement (owner);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FKqy3hyiptyuoo0ik8nfewymdio 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKqy3hyiptyuoo0ik8nfewymdio on identityiq.spt_identity_entitlement (application);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FKjief1jwgixlilqiqsvkpx0k9e 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKjief1jwgixlilqiqsvkpx0k9e on identityiq.spt_identity_entitlement (identity_id);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FK9p3id5o2as2stlq47md58fm3b 
       foreign key (request_item) 
       references identityiq.spt_identity_request_item;
    GO

    create index FK9p3id5o2as2stlq47md58fm3b on identityiq.spt_identity_entitlement (request_item);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FKcn0l4kl1lpjkg7usf4okua4d8 
       foreign key (pending_request_item) 
       references identityiq.spt_identity_request_item;
    GO

    create index FKcn0l4kl1lpjkg7usf4okua4d8 on identityiq.spt_identity_entitlement (pending_request_item);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FKbpm8wgk9stf16g8w9ujx10qw3 
       foreign key (certification_item) 
       references identityiq.spt_certification_item;
    GO

    create index FKbpm8wgk9stf16g8w9ujx10qw3 on identityiq.spt_identity_entitlement (certification_item);
    GO

    alter table identityiq.spt_identity_entitlement 
       add constraint FK6cwcsuwgv6ydwqpnm6jto062q 
       foreign key (pending_certification_item) 
       references identityiq.spt_certification_item;
    GO

    create index FK6cwcsuwgv6ydwqpnm6jto062q on identityiq.spt_identity_entitlement (pending_certification_item);
    GO

    alter table identityiq.spt_identity_history_item 
       add constraint FKji55d6komkmaodbat8ykt27ut 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKji55d6komkmaodbat8ykt27ut on identityiq.spt_identity_history_item (owner);
    GO

    alter table identityiq.spt_identity_history_item 
       add constraint FKa9cu5shr2oefnkrrew96b98nc 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKa9cu5shr2oefnkrrew96b98nc on identityiq.spt_identity_history_item (identity_id);
    GO

    alter table identityiq.spt_identity_request 
       add constraint FKrnecq87gn8rjrj2vbn9koxwc1 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKrnecq87gn8rjrj2vbn9koxwc1 on identityiq.spt_identity_request (owner);
    GO

    alter table identityiq.spt_identity_request 
       add constraint FKpstoy7u3dse9pl2h5ryub6h0w 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKpstoy7u3dse9pl2h5ryub6h0w on identityiq.spt_identity_request (assigned_scope);
    GO

    alter table identityiq.spt_identity_request_item 
       add constraint FKdrgm0omo927u9hkgtx0m4rbmb 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKdrgm0omo927u9hkgtx0m4rbmb on identityiq.spt_identity_request_item (owner);
    GO

    alter table identityiq.spt_identity_request_item 
       add constraint FKfax65ddwd2dwvkt9rsdqthshd 
       foreign key (identity_request_id) 
       references identityiq.spt_identity_request;
    GO

    create index FKfax65ddwd2dwvkt9rsdqthshd on identityiq.spt_identity_request_item (identity_request_id);
    GO

    alter table identityiq.spt_identity_role_metadata 
       add constraint FKlbwupgie8o3gpjt857djjipg9 
       foreign key (role_metadata_id) 
       references identityiq.spt_role_metadata;
    GO

    create index FKlbwupgie8o3gpjt857djjipg9 on identityiq.spt_identity_role_metadata (role_metadata_id);
    GO

    alter table identityiq.spt_identity_role_metadata 
       add constraint FKptvypo1q0ekqnlnt7tkl1u2na 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKptvypo1q0ekqnlnt7tkl1u2na on identityiq.spt_identity_role_metadata (identity_id);
    GO

    alter table identityiq.spt_identity_snapshot 
       add constraint FKh03yxqsq7ebvwlwcthihtym07 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKh03yxqsq7ebvwlwcthihtym07 on identityiq.spt_identity_snapshot (owner);
    GO

    alter table identityiq.spt_identity_snapshot 
       add constraint FKj24y3i8my2r0c3il58dlww3fa 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKj24y3i8my2r0c3il58dlww3fa on identityiq.spt_identity_snapshot (assigned_scope);
    GO

    alter table identityiq.spt_identity_trigger 
       add constraint FKaoupv62m0yus73314iwn0fclq 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKaoupv62m0yus73314iwn0fclq on identityiq.spt_identity_trigger (owner);
    GO

    alter table identityiq.spt_identity_trigger 
       add constraint FK6est6a8xpuhjgqv7b0d8yvmal 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK6est6a8xpuhjgqv7b0d8yvmal on identityiq.spt_identity_trigger (assigned_scope);
    GO

    alter table identityiq.spt_identity_trigger 
       add constraint FK4yqufhetuoj6wig3t5n5rw7xh 
       foreign key (rule_id) 
       references identityiq.spt_rule;
    GO

    create index FK4yqufhetuoj6wig3t5n5rw7xh on identityiq.spt_identity_trigger (rule_id);
    GO

    alter table identityiq.spt_identity_workgroups 
       add constraint FKew5309x0hinshtjed2o9p4lu8 
       foreign key (workgroup) 
       references identityiq.spt_identity;
    GO

    create index FKew5309x0hinshtjed2o9p4lu8 on identityiq.spt_identity_workgroups (workgroup);
    GO

    alter table identityiq.spt_identity_workgroups 
       add constraint FKdubcl4txlwq72y89p09vsokp3 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKdubcl4txlwq72y89p09vsokp3 on identityiq.spt_identity_workgroups (identity_id);
    GO

    alter table identityiq.spt_integration_config 
       add constraint FK9i40hwin9s24k40gf9jbcjmyg 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK9i40hwin9s24k40gf9jbcjmyg on identityiq.spt_integration_config (owner);
    GO

    alter table identityiq.spt_integration_config 
       add constraint FKkra0w53mfbawmb7tun0thw07j 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKkra0w53mfbawmb7tun0thw07j on identityiq.spt_integration_config (assigned_scope);
    GO

    alter table identityiq.spt_integration_config 
       add constraint FK4m8ag5j3ca0w07n396xv4ovlx 
       foreign key (plan_initializer) 
       references identityiq.spt_rule;
    GO

    create index FK4m8ag5j3ca0w07n396xv4ovlx on identityiq.spt_integration_config (plan_initializer);
    GO

    alter table identityiq.spt_integration_config 
       add constraint FKnn9f0lgf5ewip65a8t2mhi97u 
       foreign key (application_id) 
       references identityiq.spt_application;
    GO

    create index FKnn9f0lgf5ewip65a8t2mhi97u on identityiq.spt_integration_config (application_id);
    GO

    alter table identityiq.spt_integration_config 
       add constraint FK7dcjq7gk21x6gl2w55r9rgnnq 
       foreign key (container_id) 
       references identityiq.spt_bundle;
    GO

    create index FK7dcjq7gk21x6gl2w55r9rgnnq on identityiq.spt_integration_config (container_id);
    GO

    alter table identityiq.spt_jasper_files 
       add constraint FKarvo68602qubbljqm974ejrao 
       foreign key (elt) 
       references identityiq.spt_persisted_file;
    GO

    create index FKarvo68602qubbljqm974ejrao on identityiq.spt_jasper_files (elt);
    GO

    alter table identityiq.spt_jasper_files 
       add constraint FK38q00anepn1enkf14vh5kt0p0 
       foreign key (result) 
       references identityiq.spt_jasper_result;
    GO

    create index FK38q00anepn1enkf14vh5kt0p0 on identityiq.spt_jasper_files (result);
    GO

    alter table identityiq.spt_jasper_page_bucket 
       add constraint FK7ajqlhkio1lj6deitro8rufr4 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK7ajqlhkio1lj6deitro8rufr4 on identityiq.spt_jasper_page_bucket (owner);
    GO

    alter table identityiq.spt_jasper_page_bucket 
       add constraint FKebcpjeggovthx5rfslffvm06l 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKebcpjeggovthx5rfslffvm06l on identityiq.spt_jasper_page_bucket (assigned_scope);
    GO

    alter table identityiq.spt_jasper_result 
       add constraint FKaov2d8748uea72k8riblr9iw 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKaov2d8748uea72k8riblr9iw on identityiq.spt_jasper_result (owner);
    GO

    alter table identityiq.spt_jasper_result 
       add constraint FK48lfhuwg00rdb7lu24q8iqemj 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK48lfhuwg00rdb7lu24q8iqemj on identityiq.spt_jasper_result (assigned_scope);
    GO

    alter table identityiq.spt_jasper_template 
       add constraint FK9gqhh1f6h8uvb0ijwd2x8d3xd 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK9gqhh1f6h8uvb0ijwd2x8d3xd on identityiq.spt_jasper_template (owner);
    GO

    alter table identityiq.spt_jasper_template 
       add constraint FKd7fy4u4sv1o5q0oen7ip2trng 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKd7fy4u4sv1o5q0oen7ip2trng on identityiq.spt_jasper_template (assigned_scope);
    GO

    alter table identityiq.spt_link 
       add constraint FKlt4unsy5cp7psyl716sjq527e 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKlt4unsy5cp7psyl716sjq527e on identityiq.spt_link (owner);
    GO

    alter table identityiq.spt_link 
       add constraint FKg0l571s3kkovl1l5q24wsn5h2 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKg0l571s3kkovl1l5q24wsn5h2 on identityiq.spt_link (assigned_scope);
    GO

    alter table identityiq.spt_link 
       add constraint FK7do4oyl8j399aynq34dosvk6o 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FK7do4oyl8j399aynq34dosvk6o on identityiq.spt_link (identity_id);
    GO

    alter table identityiq.spt_link 
       add constraint FKsc0du71d7t0p5jx4sqbwlrtc7 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKsc0du71d7t0p5jx4sqbwlrtc7 on identityiq.spt_link (application);
    GO

    alter table identityiq.spt_localized_attribute 
       add constraint FK4ahm8gyl5gwhj8d4qgbwyynv 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4ahm8gyl5gwhj8d4qgbwyynv on identityiq.spt_localized_attribute (owner);
    GO

    alter table identityiq.spt_managed_attribute 
       add constraint FK3gb72xtjki5mp7uosqt8y4pvn 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK3gb72xtjki5mp7uosqt8y4pvn on identityiq.spt_managed_attribute (owner);
    GO

    alter table identityiq.spt_managed_attribute 
       add constraint FKp22ur089e238refu7d4ey3vad 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKp22ur089e238refu7d4ey3vad on identityiq.spt_managed_attribute (assigned_scope);
    GO

    alter table identityiq.spt_managed_attribute 
       add constraint FKh34qiq4aglfffr9xwpik781vj 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKh34qiq4aglfffr9xwpik781vj on identityiq.spt_managed_attribute (application);
    GO

    alter table identityiq.spt_managed_attr_inheritance 
       add constraint FK4ioitymnwqibnmecupdfuo3ri 
       foreign key (inherits_from) 
       references identityiq.spt_managed_attribute;
    GO

    create index FK4ioitymnwqibnmecupdfuo3ri on identityiq.spt_managed_attr_inheritance (inherits_from);
    GO

    alter table identityiq.spt_managed_attr_inheritance 
       add constraint FK5w1va2uar8ndocw86uxw22fyx 
       foreign key (managedattribute) 
       references identityiq.spt_managed_attribute;
    GO

    create index FK5w1va2uar8ndocw86uxw22fyx on identityiq.spt_managed_attr_inheritance (managedattribute);
    GO

    alter table identityiq.spt_managed_attr_perms 
       add constraint FKgb5h5u8b3v7q8thhsyw3a3x2d 
       foreign key (managedattribute) 
       references identityiq.spt_managed_attribute;
    GO

    create index FKgb5h5u8b3v7q8thhsyw3a3x2d on identityiq.spt_managed_attr_perms (managedattribute);
    GO

    alter table identityiq.spt_managed_attr_target_perms 
       add constraint FKgxeh9kjs3fstpnq4tp0cch0h7 
       foreign key (managedattribute) 
       references identityiq.spt_managed_attribute;
    GO

    create index FKgxeh9kjs3fstpnq4tp0cch0h7 on identityiq.spt_managed_attr_target_perms (managedattribute);
    GO

    alter table identityiq.spt_message_template 
       add constraint FKbhf643rsydyey69y4clalwes3 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKbhf643rsydyey69y4clalwes3 on identityiq.spt_message_template (owner);
    GO

    alter table identityiq.spt_message_template 
       add constraint FK93cucj6fysk1u4s1mggidhsjw 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK93cucj6fysk1u4s1mggidhsjw on identityiq.spt_message_template (assigned_scope);
    GO

    alter table identityiq.spt_mining_config 
       add constraint FKe2p3b82e1gpt5n75cfkj19573 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKe2p3b82e1gpt5n75cfkj19573 on identityiq.spt_mining_config (owner);
    GO

    alter table identityiq.spt_mining_config 
       add constraint FKo5ji502vpitlcnl4ie54trv3a 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKo5ji502vpitlcnl4ie54trv3a on identityiq.spt_mining_config (assigned_scope);
    GO

    alter table identityiq.spt_mitigation_expiration 
       add constraint FKpym4olxxt5hvtw2h6h5qehsg5 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKpym4olxxt5hvtw2h6h5qehsg5 on identityiq.spt_mitigation_expiration (owner);
    GO

    alter table identityiq.spt_mitigation_expiration 
       add constraint FKnq1a0dvm762fk9tcucs5ro4h3 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKnq1a0dvm762fk9tcucs5ro4h3 on identityiq.spt_mitigation_expiration (assigned_scope);
    GO

    alter table identityiq.spt_mitigation_expiration 
       add constraint FKrp62md93f75jd1i1hof0pdr01 
       foreign key (mitigator) 
       references identityiq.spt_identity;
    GO

    create index FKrp62md93f75jd1i1hof0pdr01 on identityiq.spt_mitigation_expiration (mitigator);
    GO

    alter table identityiq.spt_mitigation_expiration 
       add constraint FKdk2mv4vumkj87erjys2ecjjqy 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKdk2mv4vumkj87erjys2ecjjqy on identityiq.spt_mitigation_expiration (identity_id);
    GO

    alter table identityiq.spt_monitoring_statistic 
       add constraint FK1oylxmpnab6ukcexs91d4d3ps 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK1oylxmpnab6ukcexs91d4d3ps on identityiq.spt_monitoring_statistic (owner);
    GO

    alter table identityiq.spt_monitoring_statistic 
       add constraint FK66fxpvt139gb5aghd369t0q1s 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK66fxpvt139gb5aghd369t0q1s on identityiq.spt_monitoring_statistic (assigned_scope);
    GO

    alter table identityiq.spt_monitoring_statistic_tags 
       add constraint FKa6efhhukixvrd4fucp8n3hrlm 
       foreign key (elt) 
       references identityiq.spt_tag;
    GO

    create index FKa6efhhukixvrd4fucp8n3hrlm on identityiq.spt_monitoring_statistic_tags (elt);
    GO

    alter table identityiq.spt_monitoring_statistic_tags 
       add constraint FKk900lsdj83sd0cp9o59evn9nj 
       foreign key (statistic_id) 
       references identityiq.spt_monitoring_statistic;
    GO

    create index FKk900lsdj83sd0cp9o59evn9nj on identityiq.spt_monitoring_statistic_tags (statistic_id);
    GO

    alter table identityiq.spt_object_classification 
       add constraint FK4hfvqf5hc3a6rl944f4h171tn 
       foreign key (classification_id) 
       references identityiq.spt_classification;
    GO

    create index FK4hfvqf5hc3a6rl944f4h171tn on identityiq.spt_object_classification (classification_id);
    GO

    alter table identityiq.spt_object_config 
       add constraint FKtcjesncjqdcd4inr41kpgpwaj 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKtcjesncjqdcd4inr41kpgpwaj on identityiq.spt_object_config (owner);
    GO

    alter table identityiq.spt_object_config 
       add constraint FK1w6x1owivjjlgw0ojfk6aatm5 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK1w6x1owivjjlgw0ojfk6aatm5 on identityiq.spt_object_config (assigned_scope);
    GO

    alter table identityiq.spt_partition_result 
       add constraint FK9fa80qf6up4eunpumew96wmxr 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK9fa80qf6up4eunpumew96wmxr on identityiq.spt_partition_result (owner);
    GO

    alter table identityiq.spt_partition_result 
       add constraint FKguaao9nkvy8wtshwdjls9qe17 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKguaao9nkvy8wtshwdjls9qe17 on identityiq.spt_partition_result (assigned_scope);
    GO

    alter table identityiq.spt_partition_result 
       add constraint FK9svig87lf8npttavcvalbuipb 
       foreign key (task_result) 
       references identityiq.spt_task_result;
    GO

    create index FK9svig87lf8npttavcvalbuipb on identityiq.spt_partition_result (task_result);
    GO

    alter table identityiq.spt_password_policy 
       add constraint FK15k2353b0bf4swvqkteyjutb8 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK15k2353b0bf4swvqkteyjutb8 on identityiq.spt_password_policy (owner);
    GO

    alter table identityiq.spt_password_policy_holder 
       add constraint FK47skxwy6vwmh6qdkoo76gao8c 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK47skxwy6vwmh6qdkoo76gao8c on identityiq.spt_password_policy_holder (owner);
    GO

    alter table identityiq.spt_password_policy_holder 
       add constraint FK4flfb6aud9uvwfhrdt228g7b7 
       foreign key (policy) 
       references identityiq.spt_password_policy;
    GO

    create index FK4flfb6aud9uvwfhrdt228g7b7 on identityiq.spt_password_policy_holder (policy);
    GO

    alter table identityiq.spt_password_policy_holder 
       add constraint FKsa0togid3d2ers5l0u8p0xxcp 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKsa0togid3d2ers5l0u8p0xxcp on identityiq.spt_password_policy_holder (application);
    GO

    alter table identityiq.spt_persisted_file 
       add constraint FKay7i45q2li8p1lnvdybls0t3t 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKay7i45q2li8p1lnvdybls0t3t on identityiq.spt_persisted_file (owner);
    GO

    alter table identityiq.spt_persisted_file 
       add constraint FKlj0anhv8hg741lmn738bahrek 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKlj0anhv8hg741lmn738bahrek on identityiq.spt_persisted_file (assigned_scope);
    GO

    alter table identityiq.spt_plugin 
       add constraint FKr3gksq71itxj5f837unefrg31 
       foreign key (file_id) 
       references identityiq.spt_persisted_file;
    GO

    create index FKr3gksq71itxj5f837unefrg31 on identityiq.spt_plugin (file_id);
    GO

    alter table identityiq.spt_policy 
       add constraint FKij2xlldhccmq534sl8n6587od 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKij2xlldhccmq534sl8n6587od on identityiq.spt_policy (owner);
    GO

    alter table identityiq.spt_policy 
       add constraint FKoebw2yqhc4j26mx83v49qyw1n 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKoebw2yqhc4j26mx83v49qyw1n on identityiq.spt_policy (assigned_scope);
    GO

    alter table identityiq.spt_policy 
       add constraint FK3cfyso96b28h21yaml8hbc3xi 
       foreign key (violation_owner) 
       references identityiq.spt_identity;
    GO

    create index FK3cfyso96b28h21yaml8hbc3xi on identityiq.spt_policy (violation_owner);
    GO

    alter table identityiq.spt_policy 
       add constraint FKgsvi652nk5hayfr8kc7p5ydy 
       foreign key (violation_owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FKgsvi652nk5hayfr8kc7p5ydy on identityiq.spt_policy (violation_owner_rule);
    GO

    alter table identityiq.spt_policy_violation 
       add constraint FKgxlmr2yos1bq05bqb3kxjyhdy 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKgxlmr2yos1bq05bqb3kxjyhdy on identityiq.spt_policy_violation (owner);
    GO

    alter table identityiq.spt_policy_violation 
       add constraint FKlfnu8q3fgqq6w8l9t0v15gsjb 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKlfnu8q3fgqq6w8l9t0v15gsjb on identityiq.spt_policy_violation (assigned_scope);
    GO

    alter table identityiq.spt_policy_violation 
       add constraint FKphiamrjv42wu7uw5tcsbexjyw 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKphiamrjv42wu7uw5tcsbexjyw on identityiq.spt_policy_violation (identity_id);
    GO

    alter table identityiq.spt_policy_violation 
       add constraint FKcfjl95jng7hghpw478qqgajyn 
       foreign key (pending_workflow) 
       references identityiq.spt_workflow_case;
    GO

    create index FKcfjl95jng7hghpw478qqgajyn on identityiq.spt_policy_violation (pending_workflow);
    GO

    alter table identityiq.spt_process_log 
       add constraint FK7ll5fatw1p90l1quxoovyijej 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK7ll5fatw1p90l1quxoovyijej on identityiq.spt_process_log (owner);
    GO

    alter table identityiq.spt_process_log 
       add constraint FKtgm6rfk5nrdbjswf140ad6jir 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKtgm6rfk5nrdbjswf140ad6jir on identityiq.spt_process_log (assigned_scope);
    GO

    alter table identityiq.spt_profile 
       add constraint FKm77hrlacp3ynlthagggqmq8mn 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKm77hrlacp3ynlthagggqmq8mn on identityiq.spt_profile (owner);
    GO

    alter table identityiq.spt_profile 
       add constraint FKdpexklt6enpa3qq3tg34t2i72 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKdpexklt6enpa3qq3tg34t2i72 on identityiq.spt_profile (assigned_scope);
    GO

    alter table identityiq.spt_profile 
       add constraint FKb6xsupwlh8e9b6sxrsojaq107 
       foreign key (bundle_id) 
       references identityiq.spt_bundle;
    GO

    create index FKb6xsupwlh8e9b6sxrsojaq107 on identityiq.spt_profile (bundle_id);
    GO

    alter table identityiq.spt_profile 
       add constraint FKh7gmx9te7hdnjh138f0ys70bb 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKh7gmx9te7hdnjh138f0ys70bb on identityiq.spt_profile (application);
    GO

    alter table identityiq.spt_profile_constraints 
       add constraint FKfnwocslrb1d7i22e0eyyonvu6 
       foreign key (profile) 
       references identityiq.spt_profile;
    GO

    create index FKfnwocslrb1d7i22e0eyyonvu6 on identityiq.spt_profile_constraints (profile);
    GO

    alter table identityiq.spt_profile_permissions 
       add constraint FK9wkru2lsxssnhaus718md3f2o 
       foreign key (profile) 
       references identityiq.spt_profile;
    GO

    create index FK9wkru2lsxssnhaus718md3f2o on identityiq.spt_profile_permissions (profile);
    GO

    alter table identityiq.spt_provisioning_request 
       add constraint FKb0jveyf9sv2e042bjarn190pq 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKb0jveyf9sv2e042bjarn190pq on identityiq.spt_provisioning_request (owner);
    GO

    alter table identityiq.spt_provisioning_request 
       add constraint FKgtk4uysamt32hwwqxrdnceodg 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKgtk4uysamt32hwwqxrdnceodg on identityiq.spt_provisioning_request (assigned_scope);
    GO

    alter table identityiq.spt_provisioning_request 
       add constraint FKe06usqanbltc3jw079m568c9d 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKe06usqanbltc3jw079m568c9d on identityiq.spt_provisioning_request (identity_id);
    GO

    alter table identityiq.spt_quick_link 
       add constraint FKr34ji3ugpva0sp95usrgaooih 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKr34ji3ugpva0sp95usrgaooih on identityiq.spt_quick_link (owner);
    GO

    alter table identityiq.spt_quick_link 
       add constraint FK8ircuuuw7sidwf8xmatked859 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK8ircuuuw7sidwf8xmatked859 on identityiq.spt_quick_link (assigned_scope);
    GO

    alter table identityiq.spt_quick_link_options 
       add constraint FKr2janfsixof6pqahju9ab112u 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKr2janfsixof6pqahju9ab112u on identityiq.spt_quick_link_options (owner);
    GO

    alter table identityiq.spt_quick_link_options 
       add constraint FK159pqn1fd0ubpapm62cy37akd 
       foreign key (dynamic_scope) 
       references identityiq.spt_dynamic_scope;
    GO

    create index FK159pqn1fd0ubpapm62cy37akd on identityiq.spt_quick_link_options (dynamic_scope);
    GO

    alter table identityiq.spt_quick_link_options 
       add constraint FKihngfm8iqb21en8gyeebmpj7h 
       foreign key (quick_link) 
       references identityiq.spt_quick_link;
    GO

    create index FKihngfm8iqb21en8gyeebmpj7h on identityiq.spt_quick_link_options (quick_link);
    GO

    alter table identityiq.spt_remediation_item 
       add constraint FKfd9yg9q55msovcqueyjodr6ui 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKfd9yg9q55msovcqueyjodr6ui on identityiq.spt_remediation_item (owner);
    GO

    alter table identityiq.spt_remediation_item 
       add constraint FKhlirh9cempdr7546c4oegeska 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKhlirh9cempdr7546c4oegeska on identityiq.spt_remediation_item (assigned_scope);
    GO

    alter table identityiq.spt_remediation_item 
       add constraint FK6bb5fufbeok63cycwmdv1h0b3 
       foreign key (work_item_id) 
       references identityiq.spt_work_item;
    GO

    create index FK6bb5fufbeok63cycwmdv1h0b3 on identityiq.spt_remediation_item (work_item_id);
    GO

    alter table identityiq.spt_remediation_item 
       add constraint FK1vhqs5ybkgm91lv51hdyj68va 
       foreign key (assignee) 
       references identityiq.spt_identity;
    GO

    create index FK1vhqs5ybkgm91lv51hdyj68va on identityiq.spt_remediation_item (assignee);
    GO

    alter table identityiq.spt_remote_login_token 
       add constraint FKe2ofoif1sjdi94r0rhwsc6aqg 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKe2ofoif1sjdi94r0rhwsc6aqg on identityiq.spt_remote_login_token (owner);
    GO

    alter table identityiq.spt_remote_login_token 
       add constraint FK57qeahvi3aybfwrgf2mft28b0 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK57qeahvi3aybfwrgf2mft28b0 on identityiq.spt_remote_login_token (assigned_scope);
    GO

    alter table identityiq.spt_request 
       add constraint FK4wuia2w4ylm95aja22jnw6upf 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4wuia2w4ylm95aja22jnw6upf on identityiq.spt_request (owner);
    GO

    alter table identityiq.spt_request 
       add constraint FK1st2f3b62703t2anet5iykocf 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK1st2f3b62703t2anet5iykocf on identityiq.spt_request (assigned_scope);
    GO

    alter table identityiq.spt_request 
       add constraint FK2oj2nqukawo2p60yiloa72li9 
       foreign key (definition) 
       references identityiq.spt_request_definition;
    GO

    create index FK2oj2nqukawo2p60yiloa72li9 on identityiq.spt_request (definition);
    GO

    alter table identityiq.spt_request 
       add constraint FKgwavtgcmunyt6bx3fvka2a5t2 
       foreign key (task_result) 
       references identityiq.spt_task_result;
    GO

    create index FKgwavtgcmunyt6bx3fvka2a5t2 on identityiq.spt_request (task_result);
    GO

    alter table identityiq.spt_request_arguments 
       add constraint FK113ggg7785j6vdwb9xham03dc 
       foreign key (signature) 
       references identityiq.spt_request_definition;
    GO

    create index FK113ggg7785j6vdwb9xham03dc on identityiq.spt_request_arguments (signature);
    GO

    alter table identityiq.spt_request_definition 
       add constraint FKgao87b86v1y7mrylu96ow04en 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKgao87b86v1y7mrylu96ow04en on identityiq.spt_request_definition (owner);
    GO

    alter table identityiq.spt_request_definition 
       add constraint FKhe297ysa9fn4dmdljoq54njbs 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKhe297ysa9fn4dmdljoq54njbs on identityiq.spt_request_definition (assigned_scope);
    GO

    alter table identityiq.spt_request_definition 
       add constraint FK2ttetyvbubn1jvp2n9urb6m5v 
       foreign key (parent) 
       references identityiq.spt_request_definition;
    GO

    create index FK2ttetyvbubn1jvp2n9urb6m5v on identityiq.spt_request_definition (parent);
    GO

    alter table identityiq.spt_request_definition_rights 
       add constraint FKp94t40blskwg0fuh854lfml1s 
       foreign key (right_id) 
       references identityiq.spt_right;
    GO

    create index FKp94t40blskwg0fuh854lfml1s on identityiq.spt_request_definition_rights (right_id);
    GO

    alter table identityiq.spt_request_definition_rights 
       add constraint FK3drvcyrlgw6waricqagimmd8e 
       foreign key (request_definition_id) 
       references identityiq.spt_request_definition;
    GO

    create index FK3drvcyrlgw6waricqagimmd8e on identityiq.spt_request_definition_rights (request_definition_id);
    GO

    alter table identityiq.spt_request_returns 
       add constraint FKpbhfh39gtywh48gc1hlfgngox 
       foreign key (signature) 
       references identityiq.spt_request_definition;
    GO

    create index FKpbhfh39gtywh48gc1hlfgngox on identityiq.spt_request_returns (signature);
    GO

    alter table identityiq.spt_request_state 
       add constraint FKqqjbvp3qvso1sb1ca6ombgter 
       foreign key (request_id) 
       references identityiq.spt_request;
    GO

    create index FKqqjbvp3qvso1sb1ca6ombgter on identityiq.spt_request_state (request_id);
    GO

    alter table identityiq.spt_resource_event 
       add constraint FKt1snjotqsqvmoubnwv5vtpri6 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKt1snjotqsqvmoubnwv5vtpri6 on identityiq.spt_resource_event (application);
    GO

    alter table identityiq.spt_right_config 
       add constraint FKt1r57dhmuc884wt2ymu101hde 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKt1r57dhmuc884wt2ymu101hde on identityiq.spt_right_config (owner);
    GO

    alter table identityiq.spt_right_config 
       add constraint FKdx0b0oat38fxsye0jgg5ulu9k 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKdx0b0oat38fxsye0jgg5ulu9k on identityiq.spt_right_config (assigned_scope);
    GO

    alter table identityiq.spt_role_index 
       add constraint FKo7ho4tlthd9rr80looh1ooito 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKo7ho4tlthd9rr80looh1ooito on identityiq.spt_role_index (owner);
    GO

    alter table identityiq.spt_role_index 
       add constraint FKf0j6gmnubunnb5h7kfe33awf9 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKf0j6gmnubunnb5h7kfe33awf9 on identityiq.spt_role_index (assigned_scope);
    GO

    alter table identityiq.spt_role_index 
       add constraint FKl988ko9bkq0epm8ktn25tqpru 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKl988ko9bkq0epm8ktn25tqpru on identityiq.spt_role_index (bundle);
    GO

    alter table identityiq.spt_role_metadata 
       add constraint FKaa82j55vly3sm9ftky9obxd38 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKaa82j55vly3sm9ftky9obxd38 on identityiq.spt_role_metadata (owner);
    GO

    alter table identityiq.spt_role_metadata 
       add constraint FKt5qt571k5ftna1xswfi723tat 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKt5qt571k5ftna1xswfi723tat on identityiq.spt_role_metadata (assigned_scope);
    GO

    alter table identityiq.spt_role_metadata 
       add constraint FK78iwr88o7i8dt8ibvi3vusjq8 
       foreign key (role) 
       references identityiq.spt_bundle;
    GO

    create index FK78iwr88o7i8dt8ibvi3vusjq8 on identityiq.spt_role_metadata (role);
    GO

    alter table identityiq.spt_role_mining_result 
       add constraint FKjpslqep9tigfo52crhjg3hf5v 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKjpslqep9tigfo52crhjg3hf5v on identityiq.spt_role_mining_result (owner);
    GO

    alter table identityiq.spt_role_mining_result 
       add constraint FKtok5e8qk7b61q9h76g7h7pr86 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKtok5e8qk7b61q9h76g7h7pr86 on identityiq.spt_role_mining_result (assigned_scope);
    GO

    alter table identityiq.spt_role_scorecard 
       add constraint FKt6yfcgq98ed4bfi5ky81wjwdf 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKt6yfcgq98ed4bfi5ky81wjwdf on identityiq.spt_role_scorecard (owner);
    GO

    alter table identityiq.spt_role_scorecard 
       add constraint FKqrtue6hcnlf6qyr5qm0vfpwfn 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKqrtue6hcnlf6qyr5qm0vfpwfn on identityiq.spt_role_scorecard (assigned_scope);
    GO

    alter table identityiq.spt_role_scorecard 
       add constraint FK4uodpdnn6r77dbqqa4ifdqja3 
       foreign key (role_id) 
       references identityiq.spt_bundle;
    GO

    create index FK4uodpdnn6r77dbqqa4ifdqja3 on identityiq.spt_role_scorecard (role_id);
    GO

    alter table identityiq.spt_rule 
       add constraint FKebikrnbibarckvm36915k8dc7 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKebikrnbibarckvm36915k8dc7 on identityiq.spt_rule (owner);
    GO

    alter table identityiq.spt_rule 
       add constraint FKe7tgffr3v5sd2q739bndc72wr 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKe7tgffr3v5sd2q739bndc72wr on identityiq.spt_rule (assigned_scope);
    GO

    alter table identityiq.spt_rule_registry_callouts 
       add constraint FKiescqm7tqapb2r71sgdcy20jk 
       foreign key (rule_id) 
       references identityiq.spt_rule;
    GO

    create index FKiescqm7tqapb2r71sgdcy20jk on identityiq.spt_rule_registry_callouts (rule_id);
    GO

    alter table identityiq.spt_rule_registry_callouts 
       add constraint FK8csco7epf6euipthxuj0awqjp 
       foreign key (rule_registry_id) 
       references identityiq.spt_rule_registry;
    GO

    create index FK8csco7epf6euipthxuj0awqjp on identityiq.spt_rule_registry_callouts (rule_registry_id);
    GO

    alter table identityiq.spt_rule_dependencies 
       add constraint FKbju0wunboll2jdihl7c4xa0no 
       foreign key (dependency) 
       references identityiq.spt_rule;
    GO

    create index FKbju0wunboll2jdihl7c4xa0no on identityiq.spt_rule_dependencies (dependency);
    GO

    alter table identityiq.spt_rule_dependencies 
       add constraint FKgvxim0ew7xui4cfpk0gibucxa 
       foreign key (rule_id) 
       references identityiq.spt_rule;
    GO

    create index FKgvxim0ew7xui4cfpk0gibucxa on identityiq.spt_rule_dependencies (rule_id);
    GO

    alter table identityiq.spt_rule_registry 
       add constraint FKlswclannoqopuaet63sct4p74 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKlswclannoqopuaet63sct4p74 on identityiq.spt_rule_registry (owner);
    GO

    alter table identityiq.spt_rule_registry 
       add constraint FKthpyc5ikucmt8mbhdcr980ucg 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKthpyc5ikucmt8mbhdcr980ucg on identityiq.spt_rule_registry (assigned_scope);
    GO

    alter table identityiq.spt_rule_signature_arguments 
       add constraint FKdys6el89un39n7cyqey0sbdtt 
       foreign key (signature) 
       references identityiq.spt_rule;
    GO

    create index FKdys6el89un39n7cyqey0sbdtt on identityiq.spt_rule_signature_arguments (signature);
    GO

    alter table identityiq.spt_rule_signature_returns 
       add constraint FKrbsto8otv99kfe9kgyij37iml 
       foreign key (signature) 
       references identityiq.spt_rule;
    GO

    create index FKrbsto8otv99kfe9kgyij37iml on identityiq.spt_rule_signature_returns (signature);
    GO

    alter table identityiq.spt_schema_attributes 
       add constraint FKhl9i3n7y97lpqq98etsp4urds 
       foreign key (applicationschema) 
       references identityiq.spt_application_schema;
    GO

    create index FKhl9i3n7y97lpqq98etsp4urds on identityiq.spt_schema_attributes (applicationschema);
    GO

    alter table identityiq.spt_scope 
       add constraint FKht5d7wfgqvify7p0nag6egr2 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKht5d7wfgqvify7p0nag6egr2 on identityiq.spt_scope (owner);
    GO

    alter table identityiq.spt_scope 
       add constraint FK984w9lkkhtcrm8ib3y6b2qj8 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK984w9lkkhtcrm8ib3y6b2qj8 on identityiq.spt_scope (assigned_scope);
    GO

    alter table identityiq.spt_scope 
       add constraint FKpmmdhx9itj086j9dnu8ydh6gx 
       foreign key (parent_id) 
       references identityiq.spt_scope;
    GO

    create index FKpmmdhx9itj086j9dnu8ydh6gx on identityiq.spt_scope (parent_id);
    GO

    alter table identityiq.spt_scorecard 
       add constraint FK4cgtntcjhmqgrb6fcgion7psd 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK4cgtntcjhmqgrb6fcgion7psd on identityiq.spt_scorecard (owner);
    GO

    alter table identityiq.spt_scorecard 
       add constraint FKjlaay4af9d847oiooq03nwrkb 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKjlaay4af9d847oiooq03nwrkb on identityiq.spt_scorecard (assigned_scope);
    GO

    alter table identityiq.spt_scorecard 
       add constraint FKhwgs2272xcw9kr4uobastkiqj 
       foreign key (identity_id) 
       references identityiq.spt_identity;
    GO

    create index FKhwgs2272xcw9kr4uobastkiqj on identityiq.spt_scorecard (identity_id);
    GO

    alter table identityiq.spt_score_config 
       add constraint FK58s5g8wnl1pd9ckev17xhlfif 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK58s5g8wnl1pd9ckev17xhlfif on identityiq.spt_score_config (owner);
    GO

    alter table identityiq.spt_score_config 
       add constraint FKj2ff5smsk1haaiyo1w7q7pj99 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKj2ff5smsk1haaiyo1w7q7pj99 on identityiq.spt_score_config (assigned_scope);
    GO

    alter table identityiq.spt_score_config 
       add constraint FKdct987qb7na0fe12fov9gtp90 
       foreign key (right_config) 
       references identityiq.spt_right_config;
    GO

    create index FKdct987qb7na0fe12fov9gtp90 on identityiq.spt_score_config (right_config);
    GO

    alter table identityiq.spt_server_statistic 
       add constraint FKo4ubx9xkjeqxgnsil2kq8863b 
       foreign key (host) 
       references identityiq.spt_server;
    GO

    create index FKo4ubx9xkjeqxgnsil2kq8863b on identityiq.spt_server_statistic (host);
    GO

    alter table identityiq.spt_server_statistic 
       add constraint FK5q7ultbynm7wn0wki1a0vhse7 
       foreign key (monitoring_statistic) 
       references identityiq.spt_monitoring_statistic;
    GO

    create index FK5q7ultbynm7wn0wki1a0vhse7 on identityiq.spt_server_statistic (monitoring_statistic);
    GO

    alter table identityiq.spt_service_status 
       add constraint FKanvkx3ughno0yc6s33p8px5cu 
       foreign key (definition) 
       references identityiq.spt_service_definition;
    GO

    create index FKanvkx3ughno0yc6s33p8px5cu on identityiq.spt_service_status (definition);
    GO

    alter table identityiq.spt_sign_off_history 
       add constraint FKgltduyt883x1og6dkgpt9n0uj 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKgltduyt883x1og6dkgpt9n0uj on identityiq.spt_sign_off_history (owner);
    GO

    alter table identityiq.spt_sign_off_history 
       add constraint FK2ipk68cdtj3e4p6u5cp3y3ojc 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK2ipk68cdtj3e4p6u5cp3y3ojc on identityiq.spt_sign_off_history (assigned_scope);
    GO

    alter table identityiq.spt_sign_off_history 
       add constraint FKoqlo63ls25h06ufiwokvd8l9g 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FKoqlo63ls25h06ufiwokvd8l9g on identityiq.spt_sign_off_history (certification_id);
    GO

    alter table identityiq.spt_snapshot_permissions 
       add constraint FKd1pddppbj51lje4diqtw7ycs0 
       foreign key (snapshot) 
       references identityiq.spt_entitlement_snapshot;
    GO

    create index FKd1pddppbj51lje4diqtw7ycs0 on identityiq.spt_snapshot_permissions (snapshot);
    GO

    alter table identityiq.spt_sodconstraint 
       add constraint FKl4mjpujrolswau1wcu0mhn5yr 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKl4mjpujrolswau1wcu0mhn5yr on identityiq.spt_sodconstraint (owner);
    GO

    alter table identityiq.spt_sodconstraint 
       add constraint FKkdcp13gq48ggdtye8pas782pb 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKkdcp13gq48ggdtye8pas782pb on identityiq.spt_sodconstraint (assigned_scope);
    GO

    alter table identityiq.spt_sodconstraint 
       add constraint FKaoh6dc5hnbdth3l5s5el0ysg1 
       foreign key (policy) 
       references identityiq.spt_policy;
    GO

    create index FKaoh6dc5hnbdth3l5s5el0ysg1 on identityiq.spt_sodconstraint (policy);
    GO

    alter table identityiq.spt_sodconstraint 
       add constraint FK4o50l0rmgaju9n8exvb3pdf5b 
       foreign key (violation_owner) 
       references identityiq.spt_identity;
    GO

    create index FK4o50l0rmgaju9n8exvb3pdf5b on identityiq.spt_sodconstraint (violation_owner);
    GO

    alter table identityiq.spt_sodconstraint 
       add constraint FKsb73wu7qhwhp6dsypgpor8dsi 
       foreign key (violation_owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FKsb73wu7qhwhp6dsypgpor8dsi on identityiq.spt_sodconstraint (violation_owner_rule);
    GO

    alter table identityiq.spt_sodconstraint_left 
       add constraint FKiaye28ptj6gmsp4tflo13r0qy 
       foreign key (businessrole) 
       references identityiq.spt_bundle;
    GO

    create index FKiaye28ptj6gmsp4tflo13r0qy on identityiq.spt_sodconstraint_left (businessrole);
    GO

    alter table identityiq.spt_sodconstraint_left 
       add constraint FKihnxab3mjkx483ftgngk6g0h1 
       foreign key (sodconstraint) 
       references identityiq.spt_sodconstraint;
    GO

    create index FKihnxab3mjkx483ftgngk6g0h1 on identityiq.spt_sodconstraint_left (sodconstraint);
    GO

    alter table identityiq.spt_sodconstraint_right 
       add constraint FK1k33mlfft6ir3ao0scmod2y0i 
       foreign key (businessrole) 
       references identityiq.spt_bundle;
    GO

    create index FK1k33mlfft6ir3ao0scmod2y0i on identityiq.spt_sodconstraint_right (businessrole);
    GO

    alter table identityiq.spt_sodconstraint_right 
       add constraint FKi4p81605xg3ojoycpm4lyfa85 
       foreign key (sodconstraint) 
       references identityiq.spt_sodconstraint;
    GO

    create index FKi4p81605xg3ojoycpm4lyfa85 on identityiq.spt_sodconstraint_right (sodconstraint);
    GO

    alter table identityiq.spt_archived_cert_entity 
       add constraint FKt3lg6vlrrdfqy5xo76lb5p06x 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKt3lg6vlrrdfqy5xo76lb5p06x on identityiq.spt_archived_cert_entity (owner);
    GO

    alter table identityiq.spt_archived_cert_entity 
       add constraint FKo4mknf6x4lxygjwvgyoxu3me3 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKo4mknf6x4lxygjwvgyoxu3me3 on identityiq.spt_archived_cert_entity (assigned_scope);
    GO

    alter table identityiq.spt_archived_cert_entity 
       add constraint FK8salwd54pmcixneotwbg1e8t1 
       foreign key (certification_id) 
       references identityiq.spt_certification;
    GO

    create index FK8salwd54pmcixneotwbg1e8t1 on identityiq.spt_archived_cert_entity (certification_id);
    GO

    alter table identityiq.spt_archived_cert_item 
       add constraint FK877k5d95c04j14sdw91fyrnth 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK877k5d95c04j14sdw91fyrnth on identityiq.spt_archived_cert_item (owner);
    GO

    alter table identityiq.spt_archived_cert_item 
       add constraint FKhoc03daa5guh1iq2isa67wnrg 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKhoc03daa5guh1iq2isa67wnrg on identityiq.spt_archived_cert_item (assigned_scope);
    GO

    alter table identityiq.spt_archived_cert_item 
       add constraint FKhsl975h3fmcssmrsnav0xp0be 
       foreign key (parent_id) 
       references identityiq.spt_archived_cert_entity;
    GO

    create index FKhsl975h3fmcssmrsnav0xp0be on identityiq.spt_archived_cert_item (parent_id);
    GO

    alter table identityiq.spt_identity_req_item_attach 
       add constraint FK9j07eg4emep4vaseaa779fatl 
       foreign key (attachment_id) 
       references identityiq.spt_attachment;
    GO

    create index FK9j07eg4emep4vaseaa779fatl on identityiq.spt_identity_req_item_attach (attachment_id);
    GO

    alter table identityiq.spt_identity_req_item_attach 
       add constraint FK32c6p6xsumvu31gciybgj93f8 
       foreign key (identity_request_item_id) 
       references identityiq.spt_identity_request_item;
    GO

    create index FK32c6p6xsumvu31gciybgj93f8 on identityiq.spt_identity_req_item_attach (identity_request_item_id);
    GO

    alter table identityiq.spt_right 
       add constraint FKloubwfokw065ojaeb71h1oa3t 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKloubwfokw065ojaeb71h1oa3t on identityiq.spt_right (owner);
    GO

    alter table identityiq.spt_right 
       add constraint FK7xk9w0l2a9p6c0nk9vfdlgyty 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7xk9w0l2a9p6c0nk9vfdlgyty on identityiq.spt_right (assigned_scope);
    GO

    alter table identityiq.spt_sync_roles 
       add constraint FKh7gqwjigw9iepfoix8tu2u0s1 
       foreign key (bundle) 
       references identityiq.spt_bundle;
    GO

    create index FKh7gqwjigw9iepfoix8tu2u0s1 on identityiq.spt_sync_roles (bundle);
    GO

    alter table identityiq.spt_sync_roles 
       add constraint FKda7requ6nyli1ya6k205cvd9o 
       foreign key (config) 
       references identityiq.spt_integration_config;
    GO

    create index FKda7requ6nyli1ya6k205cvd9o on identityiq.spt_sync_roles (config);
    GO

    alter table identityiq.spt_tag 
       add constraint FKmgrthcu01wv36q32tftwjeqhl 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKmgrthcu01wv36q32tftwjeqhl on identityiq.spt_tag (owner);
    GO

    alter table identityiq.spt_tag 
       add constraint FK12ckbtpjb7t24wtg5p8mfjcks 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK12ckbtpjb7t24wtg5p8mfjcks on identityiq.spt_tag (assigned_scope);
    GO

    alter table identityiq.spt_target 
       add constraint FKey1ldelkwgfnih0bfqsxdy54w 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKey1ldelkwgfnih0bfqsxdy54w on identityiq.spt_target (owner);
    GO

    alter table identityiq.spt_target 
       add constraint FKpod5pba81d9huchum3nsgmpta 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKpod5pba81d9huchum3nsgmpta on identityiq.spt_target (assigned_scope);
    GO

    alter table identityiq.spt_target 
       add constraint FKai0hmu3219oowiyrjm6ejvh9n 
       foreign key (target_source) 
       references identityiq.spt_target_source;
    GO

    create index FKai0hmu3219oowiyrjm6ejvh9n on identityiq.spt_target (target_source);
    GO

    alter table identityiq.spt_target 
       add constraint FKb3tg6yji6uf5blcn269udqlc7 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FKb3tg6yji6uf5blcn269udqlc7 on identityiq.spt_target (application);
    GO

    alter table identityiq.spt_target 
       add constraint FKn6mv8xwf0vmk1boohfqq13gyy 
       foreign key (parent) 
       references identityiq.spt_target;
    GO

    create index FKn6mv8xwf0vmk1boohfqq13gyy on identityiq.spt_target (parent);
    GO

    alter table identityiq.spt_target_association 
       add constraint FKqxsb4h4ti40gf0t8ljtscryya 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKqxsb4h4ti40gf0t8ljtscryya on identityiq.spt_target_association (owner);
    GO

    alter table identityiq.spt_target_association 
       add constraint FKacuykan45qff45db9sj11osbl 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKacuykan45qff45db9sj11osbl on identityiq.spt_target_association (assigned_scope);
    GO

    alter table identityiq.spt_target_association 
       add constraint FKhb5il4oxcsn64hbdebuinih52 
       foreign key (target_id) 
       references identityiq.spt_target;
    GO

    create index FKhb5il4oxcsn64hbdebuinih52 on identityiq.spt_target_association (target_id);
    GO

    alter table identityiq.spt_target_source 
       add constraint FKj89r4te5s353ptcfnd2d7q5u8 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKj89r4te5s353ptcfnd2d7q5u8 on identityiq.spt_target_source (owner);
    GO

    alter table identityiq.spt_target_source 
       add constraint FKrnt6pd9p8kkfv61w0330xhib6 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKrnt6pd9p8kkfv61w0330xhib6 on identityiq.spt_target_source (assigned_scope);
    GO

    alter table identityiq.spt_target_source 
       add constraint FK2j9mi5mcplk3qdb3j0fs4id0t 
       foreign key (correlation_rule) 
       references identityiq.spt_rule;
    GO

    create index FK2j9mi5mcplk3qdb3j0fs4id0t on identityiq.spt_target_source (correlation_rule);
    GO

    alter table identityiq.spt_target_source 
       add constraint FKiu2mtbwoueit24pmdr3lhjrk6 
       foreign key (creation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKiu2mtbwoueit24pmdr3lhjrk6 on identityiq.spt_target_source (creation_rule);
    GO

    alter table identityiq.spt_target_source 
       add constraint FK777oa2vyijp2mq02nuosr81rj 
       foreign key (refresh_rule) 
       references identityiq.spt_rule;
    GO

    create index FK777oa2vyijp2mq02nuosr81rj on identityiq.spt_target_source (refresh_rule);
    GO

    alter table identityiq.spt_target_source 
       add constraint FKrtx5xfiieasobegbhbn9i6f2q 
       foreign key (transformation_rule) 
       references identityiq.spt_rule;
    GO

    create index FKrtx5xfiieasobegbhbn9i6f2q on identityiq.spt_target_source (transformation_rule);
    GO

    alter table identityiq.spt_target_sources 
       add constraint FKeoqgr9sni7dx3wv0jo0kurppy 
       foreign key (elt) 
       references identityiq.spt_target_source;
    GO

    create index FKeoqgr9sni7dx3wv0jo0kurppy on identityiq.spt_target_sources (elt);
    GO

    alter table identityiq.spt_target_sources 
       add constraint FK40hwxe8hphgbyoudtsmolx954 
       foreign key (application) 
       references identityiq.spt_application;
    GO

    create index FK40hwxe8hphgbyoudtsmolx954 on identityiq.spt_target_sources (application);
    GO

    alter table identityiq.spt_task_definition 
       add constraint FKj73ffat8whj2sjle6vcnmit5s 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKj73ffat8whj2sjle6vcnmit5s on identityiq.spt_task_definition (owner);
    GO

    alter table identityiq.spt_task_definition 
       add constraint FKijib486kukyyjtf2i4jl4r8x7 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKijib486kukyyjtf2i4jl4r8x7 on identityiq.spt_task_definition (assigned_scope);
    GO

    alter table identityiq.spt_task_definition 
       add constraint FK186b24jneods52l19ovut3k25 
       foreign key (parent) 
       references identityiq.spt_task_definition;
    GO

    create index FK186b24jneods52l19ovut3k25 on identityiq.spt_task_definition (parent);
    GO

    alter table identityiq.spt_task_definition 
       add constraint FKq967ll6qee151kju0h7uwn0sj 
       foreign key (signoff_config) 
       references identityiq.spt_work_item_config;
    GO

    create index FKq967ll6qee151kju0h7uwn0sj on identityiq.spt_task_definition (signoff_config);
    GO

    alter table identityiq.spt_task_definition_rights 
       add constraint FK9ah4pq0yle4556apcis8agx3w 
       foreign key (right_id) 
       references identityiq.spt_right;
    GO

    create index FK9ah4pq0yle4556apcis8agx3w on identityiq.spt_task_definition_rights (right_id);
    GO

    alter table identityiq.spt_task_definition_rights 
       add constraint FKf7c9o0fl64otsf323bw9lmq3l 
       foreign key (task_definition_id) 
       references identityiq.spt_task_definition;
    GO

    create index FKf7c9o0fl64otsf323bw9lmq3l on identityiq.spt_task_definition_rights (task_definition_id);
    GO

    alter table identityiq.spt_task_event 
       add constraint FKdr9qfdwq639526kr0s8sn7bsv 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKdr9qfdwq639526kr0s8sn7bsv on identityiq.spt_task_event (owner);
    GO

    alter table identityiq.spt_task_event 
       add constraint FK37pe16gm4jk5rq0iqhoxu1flp 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK37pe16gm4jk5rq0iqhoxu1flp on identityiq.spt_task_event (assigned_scope);
    GO

    alter table identityiq.spt_task_event 
       add constraint FKjbek8dno75kki81omnix1vn8e 
       foreign key (task_result) 
       references identityiq.spt_task_result;
    GO

    create index FKjbek8dno75kki81omnix1vn8e on identityiq.spt_task_event (task_result);
    GO

    alter table identityiq.spt_task_event 
       add constraint FKsvucgoph5pot9sayepcakum3t 
       foreign key (rule_id) 
       references identityiq.spt_rule;
    GO

    create index FKsvucgoph5pot9sayepcakum3t on identityiq.spt_task_event (rule_id);
    GO

    alter table identityiq.spt_task_result 
       add constraint FK92o7l61ctqgwtb3hnpk8m6nsi 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK92o7l61ctqgwtb3hnpk8m6nsi on identityiq.spt_task_result (owner);
    GO

    alter table identityiq.spt_task_result 
       add constraint FKc3i98bcpobratwtdvynrb0d8p 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKc3i98bcpobratwtdvynrb0d8p on identityiq.spt_task_result (assigned_scope);
    GO

    alter table identityiq.spt_task_result 
       add constraint FKgv5931h4qht8l60ds42fhay5n 
       foreign key (definition) 
       references identityiq.spt_task_definition;
    GO

    create index FKgv5931h4qht8l60ds42fhay5n on identityiq.spt_task_result (definition);
    GO

    alter table identityiq.spt_task_result 
       add constraint FKhmia6kghdf1stidg0tjawwrqh 
       foreign key (report) 
       references identityiq.spt_jasper_result;
    GO

    create index FKhmia6kghdf1stidg0tjawwrqh on identityiq.spt_task_result (report);
    GO

    alter table identityiq.spt_task_signature_arguments 
       add constraint FK6lxnqcijv324bs8sgqjaclh84 
       foreign key (signature) 
       references identityiq.spt_task_definition;
    GO

    create index FK6lxnqcijv324bs8sgqjaclh84 on identityiq.spt_task_signature_arguments (signature);
    GO

    alter table identityiq.spt_task_signature_returns 
       add constraint FKo0dpi7g348h1boy75cfec0khg 
       foreign key (signature) 
       references identityiq.spt_task_definition;
    GO

    create index FKo0dpi7g348h1boy75cfec0khg on identityiq.spt_task_signature_returns (signature);
    GO

    alter table identityiq.spt_time_period 
       add constraint FKm868jhewgm53i6bl4y59nbefl 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKm868jhewgm53i6bl4y59nbefl on identityiq.spt_time_period (owner);
    GO

    alter table identityiq.spt_time_period 
       add constraint FKgrcbpbx476sf3yc5jq81wh0se 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKgrcbpbx476sf3yc5jq81wh0se on identityiq.spt_time_period (assigned_scope);
    GO

    alter table identityiq.spt_uiconfig 
       add constraint FK16y8ue1ela4vu4nww3kswhtji 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK16y8ue1ela4vu4nww3kswhtji on identityiq.spt_uiconfig (owner);
    GO

    alter table identityiq.spt_uiconfig 
       add constraint FKqj3gj76e5girakxi3nejkch3s 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKqj3gj76e5girakxi3nejkch3s on identityiq.spt_uiconfig (assigned_scope);
    GO

    alter table identityiq.spt_uipreferences 
       add constraint FK5rj3vu68py43jjx519hqwnh3t 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK5rj3vu68py43jjx519hqwnh3t on identityiq.spt_uipreferences (owner);
    GO

    alter table identityiq.spt_widget 
       add constraint FKi51uo1quso8fdclqgeoj1q5hq 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKi51uo1quso8fdclqgeoj1q5hq on identityiq.spt_widget (owner);
    GO

    alter table identityiq.spt_widget 
       add constraint FK7tc8b6i3k86o36mru85lyhw3p 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK7tc8b6i3k86o36mru85lyhw3p on identityiq.spt_widget (assigned_scope);
    GO

    alter table identityiq.spt_workflow 
       add constraint FKyvogiw1fu3oegof5fxs2vku8 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKyvogiw1fu3oegof5fxs2vku8 on identityiq.spt_workflow (owner);
    GO

    alter table identityiq.spt_workflow 
       add constraint FK1i4qorrnciecvgdvblwrp125e 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FK1i4qorrnciecvgdvblwrp125e on identityiq.spt_workflow (assigned_scope);
    GO

    alter table identityiq.spt_workflow_rule_libraries 
       add constraint FKc3ft08r09xw4cwx2tqqnevcxp 
       foreign key (dependency) 
       references identityiq.spt_rule;
    GO

    create index FKc3ft08r09xw4cwx2tqqnevcxp on identityiq.spt_workflow_rule_libraries (dependency);
    GO

    alter table identityiq.spt_workflow_rule_libraries 
       add constraint FKec9mwyk8lv87b7fknm22ax1by 
       foreign key (rule_id) 
       references identityiq.spt_workflow;
    GO

    create index FKec9mwyk8lv87b7fknm22ax1by on identityiq.spt_workflow_rule_libraries (rule_id);
    GO

    alter table identityiq.spt_workflow_case 
       add constraint FK3u37v00ff74e4vm5plubtlqx1 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK3u37v00ff74e4vm5plubtlqx1 on identityiq.spt_workflow_case (owner);
    GO

    alter table identityiq.spt_workflow_case 
       add constraint FKklde6fd36kr42tbcep5f16dj9 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKklde6fd36kr42tbcep5f16dj9 on identityiq.spt_workflow_case (assigned_scope);
    GO

    alter table identityiq.spt_workflow_registry 
       add constraint FK46n0i40i7596wrm4r19mkf95o 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK46n0i40i7596wrm4r19mkf95o on identityiq.spt_workflow_registry (owner);
    GO

    alter table identityiq.spt_workflow_registry 
       add constraint FKg1y46rf6jkacnl8vtiie6wp5i 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKg1y46rf6jkacnl8vtiie6wp5i on identityiq.spt_workflow_registry (assigned_scope);
    GO

    alter table identityiq.spt_workflow_target 
       add constraint FKnhcve6g96fyukhtjqu5utjf16 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKnhcve6g96fyukhtjqu5utjf16 on identityiq.spt_workflow_target (owner);
    GO

    alter table identityiq.spt_workflow_target 
       add constraint FKjngjkgjmpbwwn9utpq60r7lid 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKjngjkgjmpbwwn9utpq60r7lid on identityiq.spt_workflow_target (assigned_scope);
    GO

    alter table identityiq.spt_workflow_target 
       add constraint FKj7uvhprilx2f9fb2u5bcoixwj 
       foreign key (workflow_case_id) 
       references identityiq.spt_workflow_case;
    GO

    create index FKj7uvhprilx2f9fb2u5bcoixwj on identityiq.spt_workflow_target (workflow_case_id);
    GO

    alter table identityiq.spt_work_item 
       add constraint FK2arasbenw5pc3vrsnwvxqmc1n 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FK2arasbenw5pc3vrsnwvxqmc1n on identityiq.spt_work_item (owner);
    GO

    alter table identityiq.spt_work_item 
       add constraint FKaqhklr6jna0canhsmjv6q3ttv 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKaqhklr6jna0canhsmjv6q3ttv on identityiq.spt_work_item (assigned_scope);
    GO

    alter table identityiq.spt_work_item 
       add constraint FKgkr4i2su940s244kebgc1f4ak 
       foreign key (requester) 
       references identityiq.spt_identity;
    GO

    create index FKgkr4i2su940s244kebgc1f4ak on identityiq.spt_work_item (requester);
    GO

    alter table identityiq.spt_work_item 
       add constraint FKb5kty2abf9yebckhbo6vqjv2l 
       foreign key (workflow_case) 
       references identityiq.spt_workflow_case;
    GO

    create index FKb5kty2abf9yebckhbo6vqjv2l on identityiq.spt_work_item (workflow_case);
    GO

    alter table identityiq.spt_work_item 
       add constraint FKnq8ngnioi09kpss4md9jkr4dq 
       foreign key (assignee) 
       references identityiq.spt_identity;
    GO

    create index FKnq8ngnioi09kpss4md9jkr4dq on identityiq.spt_work_item (assignee);
    GO

    alter table identityiq.spt_work_item 
       add constraint FK77ut3s987e5m9gcoj1yi7ifvo 
       foreign key (certification_ref_id) 
       references identityiq.spt_certification;
    GO

    create index FK77ut3s987e5m9gcoj1yi7ifvo on identityiq.spt_work_item (certification_ref_id);
    GO

    alter table identityiq.spt_work_item_comments 
       add constraint FKrcoqbshrurwy6exnqljnk9147 
       foreign key (work_item) 
       references identityiq.spt_work_item;
    GO

    create index FKrcoqbshrurwy6exnqljnk9147 on identityiq.spt_work_item_comments (work_item);
    GO

    alter table identityiq.spt_work_item_archive 
       add constraint FKi7l692hi3ind4q445liu4vnjt 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKi7l692hi3ind4q445liu4vnjt on identityiq.spt_work_item_archive (owner);
    GO

    alter table identityiq.spt_work_item_archive 
       add constraint FKr1av5cjgksel3fq0cop2449dm 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKr1av5cjgksel3fq0cop2449dm on identityiq.spt_work_item_archive (assigned_scope);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FKsaklnun9f7m1ur66reimsj0uh 
       foreign key (owner) 
       references identityiq.spt_identity;
    GO

    create index FKsaklnun9f7m1ur66reimsj0uh on identityiq.spt_work_item_config (owner);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FKainfds5d2eyh6kt0nudndtjhq 
       foreign key (assigned_scope) 
       references identityiq.spt_scope;
    GO

    create index FKainfds5d2eyh6kt0nudndtjhq on identityiq.spt_work_item_config (assigned_scope);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FK9fsd71n6x6rgg14g3ipecbei7 
       foreign key (parent) 
       references identityiq.spt_work_item_config;
    GO

    create index FK9fsd71n6x6rgg14g3ipecbei7 on identityiq.spt_work_item_config (parent);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FKml61l0hu4ipdc0uyusn0u0s4q 
       foreign key (owner_rule) 
       references identityiq.spt_rule;
    GO

    create index FKml61l0hu4ipdc0uyusn0u0s4q on identityiq.spt_work_item_config (owner_rule);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FKlmrrs1xltdogce59jno83xvqv 
       foreign key (notification_email) 
       references identityiq.spt_email_template;
    GO

    create index FKlmrrs1xltdogce59jno83xvqv on identityiq.spt_work_item_config (notification_email);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FK2p700iypxpxmrijecptg3bfc9 
       foreign key (reminder_email) 
       references identityiq.spt_email_template;
    GO

    create index FK2p700iypxpxmrijecptg3bfc9 on identityiq.spt_work_item_config (reminder_email);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FKobeui00a317gyix189atb3dt8 
       foreign key (escalation_email) 
       references identityiq.spt_email_template;
    GO

    create index FKobeui00a317gyix189atb3dt8 on identityiq.spt_work_item_config (escalation_email);
    GO

    alter table identityiq.spt_work_item_config 
       add constraint FK8ya24kn74wr4rmd8ukl7vuv9d 
       foreign key (escalation_rule) 
       references identityiq.spt_rule;
    GO

    create index FK8ya24kn74wr4rmd8ukl7vuv9d on identityiq.spt_work_item_config (escalation_rule);
    GO

    alter table identityiq.spt_work_item_owners 
       add constraint FK4m6v8uagrglqptlephg9ecbm5 
       foreign key (elt) 
       references identityiq.spt_identity;
    GO

    create index FK4m6v8uagrglqptlephg9ecbm5 on identityiq.spt_work_item_owners (elt);
    GO

    alter table identityiq.spt_work_item_owners 
       add constraint FKjpvcxuqhodero8m8cyucavel9 
       foreign key (config) 
       references identityiq.spt_work_item_config;
    GO

    create index FKjpvcxuqhodero8m8cyucavel9 on identityiq.spt_work_item_owners (config);
    GO

    create index spt_managed_modified on identityiq.spt_managed_attribute (modified);
    GO

    create index spt_managed_created on identityiq.spt_managed_attribute (created);
    GO

    create index spt_managed_comp on identityiq.spt_managed_attribute (application, type, attribute, value);
    GO

    create index spt_application_created on identityiq.spt_application (created);
    GO

    create index spt_application_modified on identityiq.spt_application (modified);
    GO

    create index spt_request_completed on identityiq.spt_request (completed);
    GO

    create index spt_request_host on identityiq.spt_request (host);
    GO

    create index spt_request_launched on identityiq.spt_request (launched);
    GO

    create index spt_request_id_composite on identityiq.spt_request (completed, next_launch, launched);
    GO

    create index spt_workitem_owner_type on identityiq.spt_work_item (owner, type);
    GO

    create index spt_role_change_event_created on identityiq.spt_role_change_event (created);
    GO

    create index spt_audit_event_created on identityiq.spt_audit_event (created);
    GO

    create index spt_audit_event_targ_act_comp on identityiq.spt_audit_event (target, action);
    GO

    create index spt_ident_entit_comp_name on identityiq.spt_identity_entitlement (identity_id, name);
    GO

    create index spt_identity_entitlement_comp on identityiq.spt_identity_entitlement (identity_id, application, native_identity, instance);
    GO

    create index spt_idrequest_created on identityiq.spt_identity_request (created);
    GO

    create index spt_arch_cert_item_apps_name on identityiq.spt_arch_cert_item_apps (application_name);
    GO

    create index spt_appidcomposite on identityiq.spt_link (application, native_identity);
    GO

    create index spt_uuidcomposite on identityiq.spt_link (application, uuid);
    GO

    create index spt_task_result_host on identityiq.spt_task_result (host);
    GO

    create index spt_task_result_launcher on identityiq.spt_task_result (launcher);
    GO

    create index spt_task_result_created on identityiq.spt_task_result (created);
    GO

    create index spt_cert_item_apps_name on identityiq.spt_cert_item_applications (application_name);
    GO

    create index spt_cert_item_att_name_ci on identityiq.spt_certification_item (exception_attribute_name);
    GO

    create index spt_certification_item_tdn_ci on identityiq.spt_certification_item (target_display_name);
    GO

    create index spt_appidcompositedelobj on identityiq.spt_deleted_object (application, native_identity);
    GO

    create index spt_uuidcompositedelobj on identityiq.spt_deleted_object (application, uuid);
    GO

    create index spt_cert_entity_tdn_ci on identityiq.spt_certification_entity (target_display_name);
    GO

    create index spt_integration_conf_modified on identityiq.spt_integration_config (modified);
    GO

    create index spt_integration_conf_created on identityiq.spt_integration_config (created);
    GO

    create index spt_bundle_modified on identityiq.spt_bundle (modified);
    GO

    create index spt_bundle_created on identityiq.spt_bundle (created);
    GO

    create index SPT_IDXE5D0EE5E14FE3C13 on identityiq.spt_certification_archive (created);
    GO

    create index spt_identity_snapshot_created on identityiq.spt_identity_snapshot (created);
    GO

    create index spt_certification_certifiers on identityiq.spt_certifiers (certifier);
    GO

    create index spt_identity_modified on identityiq.spt_identity (modified);
    GO

    create index spt_identity_created on identityiq.spt_identity (created);
    GO

    create index spt_externaloidnamecomposite on identityiq.spt_identity_external_attr (object_id, attribute_name);
    GO

    create index SPT_IDX5B44307DE376B265 on identityiq.spt_link_external_attr (object_id, attribute_name);
    GO

    create index spt_externalobjectid on identityiq.spt_identity_external_attr (object_id);
    GO

    create index SPT_IDX1CE9A5A5A51C278D on identityiq.spt_link_external_attr (object_id);
    GO

    create index spt_externalnamevalcomposite on identityiq.spt_identity_external_attr (attribute_name, value);
    GO

    create index SPT_IDX6810487CF042CA64 on identityiq.spt_link_external_attr (attribute_name, value);
    GO

    create index SPT_IDXC8BAE6DCF83839CC on identityiq.spt_jasper_template (assigned_scope_path);
    GO

    create index spt_custom_assignedscopepath on identityiq.spt_custom (assigned_scope_path);
    GO

    create index SPT_IDX52403791F605046 on identityiq.spt_generic_constraint (assigned_scope_path);
    GO

    create index SPT_IDX352BB37529C8F73E on identityiq.spt_identity_archive (assigned_scope_path);
    GO

    create index SPT_IDXD9728B9EEB248FD0 on identityiq.spt_certification_group (assigned_scope_path);
    GO

    create index SPT_IDXECB4C9F64AB87280 on identityiq.spt_group_index (assigned_scope_path);
    GO

    create index spt_category_assignedscopepath on identityiq.spt_category (assigned_scope_path);
    GO

    create index SPT_IDXCA5C5C012C739356 on identityiq.spt_certification_delegation (assigned_scope_path);
    GO

    create index SPT_IDX892D67C7AB213062 on identityiq.spt_group_definition (assigned_scope_path);
    GO

    create index spt_right_assignedscopepath on identityiq.spt_right (assigned_scope_path);
    GO

    create index SPT_IDX6B29BC60611AFDD4 on identityiq.spt_managed_attribute (assigned_scope_path);
    GO

    create index SPT_IDXA6D194B42059DB7C on identityiq.spt_application (assigned_scope_path);
    GO

    create index SPT_IDXE2B6FD83726D2C4 on identityiq.spt_process_log (assigned_scope_path);
    GO

    create index spt_request_assignedscopepath on identityiq.spt_request (assigned_scope_path);
    GO

    create index SPT_IDX6BA77F433361865A on identityiq.spt_score_config (assigned_scope_path);
    GO

    create index SPT_IDX1647668E11063E4 on identityiq.spt_work_item_archive (assigned_scope_path);
    GO

    create index SPT_IDX2AE3D4A6385CD3E0 on identityiq.spt_message_template (assigned_scope_path);
    GO

    create index SPT_IDX749C6E992BBAE86 on identityiq.spt_dictionary_term (assigned_scope_path);
    GO

    create index SPT_IDX836C2831FD8ED7B6 on identityiq.spt_file_bucket (assigned_scope_path);
    GO

    create index SPT_IDX45D72A5E6CEE19E on identityiq.spt_work_item (assigned_scope_path);
    GO

    create index SPT_IDX9542C8399A0989C6 on identityiq.spt_bundle_archive (assigned_scope_path);
    GO

    create index SPT_IDX5BFDE38499178D1C on identityiq.spt_rule_registry (assigned_scope_path);
    GO

    create index SPT_IDXBB0D4BCC29515FAC on identityiq.spt_policy_violation (assigned_scope_path);
    GO

    create index SPT_IDXC1811197B7DE5802 on identityiq.spt_role_mining_result (assigned_scope_path);
    GO

    create index SPT_IDX5165831AA4CEA5C8 on identityiq.spt_audit_event (assigned_scope_path);
    GO

    create index spt_tag_assignedscopepath on identityiq.spt_tag (assigned_scope_path);
    GO

    create index spt_uiconfig_assignedscopepath on identityiq.spt_uiconfig (assigned_scope_path);
    GO

    create index SPT_IDX8F4ABD86AFAD1DA0 on identityiq.spt_scorecard (assigned_scope_path);
    GO

    create index SPT_IDX8DFD31878D3B3E2 on identityiq.spt_target_association (assigned_scope_path);
    GO

    create index SPT_IDX686990949D3B0B3C on identityiq.spt_activity_data_source (assigned_scope_path);
    GO

    create index SPT_IDX59D4F6CD8690EEC on identityiq.spt_certification_definition (assigned_scope_path);
    GO

    create index SPT_IDX377FCC029A032198 on identityiq.spt_identity_request (assigned_scope_path);
    GO

    create index SPT_IDXA6919D21F9F21D96 on identityiq.spt_remediation_item (assigned_scope_path);
    GO

    create index SPT_IDX608761A1BFB4BC8 on identityiq.spt_audit_config (assigned_scope_path);
    GO

    create index spt_target_assignedscopepath on identityiq.spt_target (assigned_scope_path);
    GO

    create index SPT_IDX99FA48D474C60BBC on identityiq.spt_task_event (assigned_scope_path);
    GO

    create index SPT_IDXB52E1053EF6BCC7A on identityiq.spt_correlation_config (assigned_scope_path);
    GO

    create index SPT_IDX7590C4E191BEDD16 on identityiq.spt_workflow_registry (assigned_scope_path);
    GO

    create index SPT_IDX99763E0AD76DF7A8 on identityiq.spt_alert_definition (assigned_scope_path);
    GO

    create index SPT_IDXE4B09B655AF1E31E on identityiq.spt_archived_cert_item (assigned_scope_path);
    GO

    create index SPT_IDX321B16EB1422CFAA on identityiq.spt_identity_trigger (assigned_scope_path);
    GO

    create index SPT_IDX660B15141EEE343C on identityiq.spt_workflow_case (assigned_scope_path);
    GO

    create index spt_rule_assignedscopepath on identityiq.spt_rule (assigned_scope_path);
    GO

    create index SPT_IDXECBE5C8C4B5A312C on identityiq.spt_capability (assigned_scope_path);
    GO

    create index SPT_IDXD6F31180C85EB014 on identityiq.spt_quick_link (assigned_scope_path);
    GO

    create index SPT_IDX4875A7F12BD64736 on identityiq.spt_authentication_question (assigned_scope_path);
    GO

    create index spt_link_assignedscopepath on identityiq.spt_link (assigned_scope_path);
    GO

    create index SPT_IDX8CEA0D6E33EF6770 on identityiq.spt_batch_request (assigned_scope_path);
    GO

    create index SPT_IDX34534BBBC845CD4A on identityiq.spt_task_result (assigned_scope_path);
    GO

    create index SPT_IDXDCCC1AEC8ACA85EC on identityiq.spt_certification_item (assigned_scope_path);
    GO

    create index SPT_IDXBED7A8DAA6E4E148 on identityiq.spt_configuration (assigned_scope_path);
    GO

    create index SPT_IDX5DA4B31DDBDDDB6 on identityiq.spt_activity_constraint (assigned_scope_path);
    GO

    create index SPT_IDX11035135399822BE on identityiq.spt_mining_config (assigned_scope_path);
    GO

    create index spt_scope_assignedscopepath on identityiq.spt_scope (assigned_scope_path);
    GO

    create index SPT_IDX719553AD788A55AE on identityiq.spt_target_source (assigned_scope_path);
    GO

    create index SPT_IDX1DB04E7170203436 on identityiq.spt_task_definition (assigned_scope_path);
    GO

    create index SPT_IDXCE071F89DBC06C66 on identityiq.spt_sodconstraint (assigned_scope_path);
    GO

    create index SPT_IDXC71C52111BEFE376 on identityiq.spt_account_group (assigned_scope_path);
    GO

    create index SPT_IDX593FB9116D127176 on identityiq.spt_entitlement_group (assigned_scope_path);
    GO

    create index SPT_IDX7F55103C9C96248C on identityiq.spt_role_metadata (assigned_scope_path);
    GO

    create index SPT_IDXCEBEA62E59148F0 on identityiq.spt_group_factory (assigned_scope_path);
    GO

    create index SPT_IDX7EDDBC591F6A3A06 on identityiq.spt_deleted_object (assigned_scope_path);
    GO

    create index SPT_IDX1A2CF87C3B1B850C on identityiq.spt_certification_entity (assigned_scope_path);
    GO

    create index SPT_IDXFB512F02CB48A798 on identityiq.spt_certification_challenge (assigned_scope_path);
    GO

    create index SPT_IDXABF0D041BEBD0BD6 on identityiq.spt_integration_config (assigned_scope_path);
    GO

    create index SPT_IDXAEACA8FDA84AB44E on identityiq.spt_role_index (assigned_scope_path);
    GO

    create index SPT_IDXF70D54D58BC80EE on identityiq.spt_role_scorecard (assigned_scope_path);
    GO

    create index spt_widget_assignedscopepath on identityiq.spt_widget (assigned_scope_path);
    GO

    create index SPT_IDXCB6BC61E1128A4D0 on identityiq.spt_remote_login_token (assigned_scope_path);
    GO

    create index spt_form_assignedscopepath on identityiq.spt_form (assigned_scope_path);
    GO

    create index SPT_IDXA367F317D4A97B02 on identityiq.spt_application_scorecard (assigned_scope_path);
    GO

    create index SPT_IDX54AF7352EE4EEBE on identityiq.spt_workflow_target (assigned_scope_path);
    GO

    create index SPT_IDXA5EE253FB5399952 on identityiq.spt_jasper_result (assigned_scope_path);
    GO

    create index SPT_IDXC439D3638206900 on identityiq.spt_sign_off_history (assigned_scope_path);
    GO

    create index SPT_IDX6200CF1CF3199A4C on identityiq.spt_batch_request_item (assigned_scope_path);
    GO

    create index SPT_IDXDD339B534953A27A on identityiq.spt_mitigation_expiration (assigned_scope_path);
    GO

    create index SPT_IDX9D89C40FB709EAF2 on identityiq.spt_certification_action (assigned_scope_path);
    GO

    create index SPT_IDXBAE32AF9A1817F46 on identityiq.spt_right_config (assigned_scope_path);
    GO

    create index spt_workflow_assignedscopepath on identityiq.spt_workflow (assigned_scope_path);
    GO

    create index SPT_IDXF89E6D4D93CDB0EE on identityiq.spt_monitoring_statistic (assigned_scope_path);
    GO

    create index spt_profile_assignedscopepath on identityiq.spt_profile (assigned_scope_path);
    GO

    create index spt_bundle_assignedscopepath on identityiq.spt_bundle (assigned_scope_path);
    GO

    create index SPT_IDX823D9A61B16AE816 on identityiq.spt_certification_archive (assigned_scope_path);
    GO

    create index SPT_IDXB1547649C7A749E6 on identityiq.spt_identity_snapshot (assigned_scope_path);
    GO

    create index SPT_IDXBAF33EB59EE05DBE on identityiq.spt_archived_cert_entity (assigned_scope_path);
    GO

    create index SPT_IDXFF9A9E0694DBFEA0 on identityiq.spt_partition_result (assigned_scope_path);
    GO

    create index SPT_IDX133BD716174D236 on identityiq.spt_provisioning_request (assigned_scope_path);
    GO

    create index SPT_IDX50B36EB8F7F2C884 on identityiq.spt_dynamic_scope (assigned_scope_path);
    GO

    create index SPT_IDX95FDCE46C5917DC on identityiq.spt_application_schema (assigned_scope_path);
    GO

    create index SPT_IDXE758C3D7FFA1CC82 on identityiq.spt_attachment (assigned_scope_path);
    GO

    create index SPT_IDX52AF250AB5405B4 on identityiq.spt_jasper_page_bucket (assigned_scope_path);
    GO

    create index SPT_IDX1E683C17685A4D02 on identityiq.spt_time_period (assigned_scope_path);
    GO

    create index SPT_IDX90929F9EDF01B7D0 on identityiq.spt_certification (assigned_scope_path);
    GO

    create index SPT_IDXEA8F35F17CF0E336 on identityiq.spt_email_template (assigned_scope_path);
    GO

    create index spt_identity_assignedscopepath on identityiq.spt_identity (assigned_scope_path);
    GO

    create index SPT_IDXA511A43C73CC4C8C on identityiq.spt_persisted_file (assigned_scope_path);
    GO

    create index SPT_IDX9393E3B78D0A4442 on identityiq.spt_request_definition (assigned_scope_path);
    GO

    create index SPT_IDXB999253482041C7C on identityiq.spt_work_item_config (assigned_scope_path);
    GO

    create index SPT_IDXD9D9048A81D024A8 on identityiq.spt_dictionary (assigned_scope_path);
    GO

    create index SPT_IDX6F2601261AB4CE0 on identityiq.spt_object_config (assigned_scope_path);
    GO

    create index spt_policy_assignedscopepath on identityiq.spt_policy (assigned_scope_path);
    GO

    create sequence identityiq.spt_syslog_event_sequence start with 1 increment by 1;
    GO

    create sequence identityiq.spt_alert_sequence start with 1 increment by 1;
    GO

    create sequence identityiq.spt_work_item_sequence start with 1 increment by 1;
    GO

    create sequence identityiq.spt_prv_trans_sequence start with 1 increment by 1;
    GO

    create sequence identityiq.spt_identity_request_sequence start with 1 increment by 1;
    GO
