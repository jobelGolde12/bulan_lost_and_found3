# ONLINE LOST AND FOUND SYSTEM FOR BULAN, SORSOGON
## Capstone project created by:
#### Jobel Golde
#### Arabella Dwaines Golpeo
#### Christine Joy Bibat
#### Kristina Lumabad
<!-- 
## Project structure
├── .editorconfig
├── .env.example
├── .gitattributes
├── .gitignore
├── README.md
├── app
    ├── Console
    │   ├── Commands
    │   │   └── DeleteOldUnclaimedItems.php
    │   └── Kernel.php
    ├── Events
    │   └── NewMessageSent.php
    ├── Http
    │   ├── Controllers
    │   │   ├── AdminDashboard.php
    │   │   ├── AnnouncementTrashController.php
    │   │   ├── Auth
    │   │   │   ├── AuthenticatedSessionController.php
    │   │   │   ├── ConfirmablePasswordController.php
    │   │   │   ├── EmailVerificationNotificationController.php
    │   │   │   ├── EmailVerificationPromptController.php
    │   │   │   ├── NewPasswordController.php
    │   │   │   ├── PasswordController.php
    │   │   │   ├── PasswordResetLinkController.php
    │   │   │   ├── RegisteredUserController.php
    │   │   │   └── VerifyEmailController.php
    │   │   ├── CommentController.php
    │   │   ├── ContactAdminController.php
    │   │   ├── Controller.php
    │   │   ├── DashboardController.php
    │   │   ├── FindMatchController.php
    │   │   ├── ItemController.php
    │   │   ├── LocationController.php
    │   │   ├── MessageController.php
    │   │   ├── MyPermissionController.php
    │   │   ├── NotificationTrashController.php
    │   │   ├── PendingRequestController.php
    │   │   ├── ProfileController.php
    │   │   ├── SettingsController.php
    │   │   ├── TotalLostItem.php
    │   │   ├── TrashController.php
    │   │   ├── UserController.php
    │   │   ├── UserInfoTrashController.php
    │   │   ├── UserTrashController.php
    │   │   ├── ViewLaterController.php
    │   │   └── ViewMoreUsers.php
    │   ├── Middleware
    │   │   └── HandleInertiaRequests.php
    │   └── Requests
    │   │   ├── Auth
    │   │       └── LoginRequest.php
    │   │   └── ProfileUpdateRequest.php
    ├── Models
    │   ├── AnnouncementModel.php
    │   ├── ArhiveItems.php
    │   ├── BlockedMessages.php
    │   ├── CategoryModel.php
    │   ├── Comment.php
    │   ├── ContactAdminModel.php
    │   ├── ItemCategories.php
    │   ├── ItemModel.php
    │   ├── LocationModel.php
    │   ├── MessageModel.php
    │   ├── MyPermissionModel.php
    │   ├── NotificationModel.php
    │   ├── PendingRequest.php
    │   ├── PinnedChatsModel.php
    │   ├── RemovePinnedMessages.php
    │   ├── TrashNotificationModel.php
    │   ├── TrashUser.php
    │   ├── TrashUserInfo.php
    │   ├── User.php
    │   ├── UserInfo.php
    │   └── ViewLaterModel.php
    ├── Providers
    │   ├── AppServiceProvider.php
    │   └── BroadcastSeviceProvider.php
    └── Services
    │   └── TwilioService.php
├── artisan
├── bootstrap
    ├── app.php
    ├── cache
    │   └── .gitignore
    └── providers.php
├── composer.json
├── composer.lock
├── config
    ├── app.php
    ├── auth.php
    ├── broadcasting.php
    ├── cache.php
    ├── database.php
    ├── filesystems.php
    ├── logging.php
    ├── mail.php
    ├── queue.php
    ├── services.php
    └── session.php
├── database
    ├── .gitignore
    ├── factories
    │   └── UserFactory.php
    ├── migrations
    │   ├── 0001_01_01_000001_create_cache_table.php
    │   ├── 2025_02_16_011340_add_info_in_items.php
    │   ├── 2025_03_30_051046_create_contact_admin_table.php
    │   ├── 2025_04_12_200908_create_pending_request_table.php
    │   ├── 2025_04_19_174238_create_resolve_cases_table.php
    │   ├── 2025_04_24_003441_add_updated_at_to_notifications_table.php
    │   ├── 2025_04_26_210508_create_pinned_chats_table.php
    │   ├── 2025_05_26_051406_add_resolved_at_to_items_table.php
    │   ├── 2025_06_07_204146_add_updated_at_in_contacts.php
    │   ├── 2025_06_07_223803_create_jobs_table.php
    │   ├── 2025_06_14_070253_add_foriegn_key_in_users_table.php
    │   ├── 2025_06_17_234950_add_softdelete_in_announcements_table.php
    │   ├── 2025_06_18_070901_add_softdelete_in_notifications_table.php
    │   ├── 2025_06_20_055957_add_softdelete_in_users_table.php
    │   ├── 2025_06_20_061800_add_softdelete_in_users_info.php
    │   ├── 2025_06_20_225625_add_softdelete_in_items_table.php
    │   ├── 2025_06_30_052221_create_removed_pinned_messages_table.php
    │   ├── 2025_06_30_090442_create_blocked_messages_table.php
    │   ├── 2025_07_04_120441_create_archived_items_table.php
    │   ├── 2025_07_09_220440_create_my_permission_table.php
    │   └── 2025_07_09_221412_add_default_values_to_my_permission_table.php
    └── seeders
    │   ├── AdminSeeder.php
    │   └── DatabaseSeeder.php
├── database_backup
    ├── bulan_lost_and_found (v1).sql
    ├── bulan_lost_and_found (v2).sql
    ├── bulan_lost_and_found (v3).sql
    ├── bulan_lost_and_found (v4).sql
    └── bulan_lost_and_found(v5).sql
├── jsconfig.json
├── package-lock.json
├── package.json
├── phpunit.xml
├── postcss.config.js
├── public
    ├── .htaccess
    ├── favicon.ico
    ├── images
    │   ├── 6864740bb680d.jpeg
    │   ├── noImage.jpg
    │   └── profile.jpeg
    ├── index.php
    └── robots.txt
├── resources
    ├── css
    │   ├── app.css
    │   ├── global.css
    │   └── welcome.css
    ├── images
    │   ├── aboutUs
    │   │   ├── connection.svg
    │   │   ├── data-reports.svg
    │   │   ├── hero.svg
    │   │   └── report.svg
    │   ├── announce.svg
    │   ├── arrow2.png
    │   ├── brows.svg
    │   ├── claim.svg
    │   ├── forgot-password.svg
    │   ├── found.svg
    │   ├── happy.svg
    │   ├── lost_and_found_logo.png
    │   ├── no-data.svg
    │   ├── noImage.jpg
    │   ├── paint.png
    │   ├── profile.jpeg
    │   └── welcome.png
    ├── js
    │   ├── Components
    │   │   ├── ApplicationLogo.vue
    │   │   ├── Checkbox.vue
    │   │   ├── CustomModal.vue
    │   │   ├── DangerButton.vue
    │   │   ├── Dropdown.vue
    │   │   ├── DropdownLink.vue
    │   │   ├── InputError.vue
    │   │   ├── InputLabel.vue
    │   │   ├── ItemCard.vue
    │   │   ├── LoadingComponent.vue
    │   │   ├── LoadingPage.vue
    │   │   ├── Modal.vue
    │   │   ├── MyPermission.vue
    │   │   ├── NavLink.vue
    │   │   ├── NotificationCard.vue
    │   │   ├── PrimaryButton.vue
    │   │   ├── ResponsiveNavLink.vue
    │   │   ├── SecondaryButton.vue
    │   │   ├── Testimonial.vue
    │   │   ├── TextInput.vue
    │   │   ├── UploadImage.vue
    │   │   ├── admin
    │   │   │   ├── ItemCardForAdmin.vue
    │   │   │   ├── OffcanvasForProfile.vue
    │   │   │   ├── PendingCard.vue
    │   │   │   ├── ViewItemInfoForAdminHeader.vue
    │   │   │   └── dashboard
    │   │   │   │   ├── FilterResolveCases.vue
    │   │   │   │   ├── FindMatchButton.vue
    │   │   │   │   ├── FindMatchCard.vue
    │   │   │   │   ├── Overview.vue
    │   │   │   │   ├── PendingRequest.vue
    │   │   │   │   ├── PendingRequestCard.vue
    │   │   │   │   ├── ProfileWithName.vue
    │   │   │   │   ├── ResolveCasesChart.vue
    │   │   │   │   ├── ResolveCasesChartYearly.vue
    │   │   │   │   ├── TotalFoundItemCard.vue
    │   │   │   │   ├── TotalLostItemCard.vue
    │   │   │   │   └── UserRegistration.vue
    │   │   ├── message
    │   │   │   ├── BackButton.vue
    │   │   │   ├── PinnedChats.vue
    │   │   │   ├── PopupForMessage.vue
    │   │   │   ├── PopupForViewMoreUsers.vue
    │   │   │   └── ToggleAllOrBlocked.vue
    │   │   ├── settings
    │   │   │   ├── AnnouncementTrashedTable.vue
    │   │   │   └── NotificationTrashedTable.vue
    │   │   ├── user
    │   │   │   ├── CategoriesList.vue
    │   │   │   ├── FilterComponent.vue
    │   │   │   ├── LogoutButton.vue
    │   │   │   └── OffcanvasForUserProfile.vue
    │   │   └── welcome_page
    │   │   │   ├── AboutSection.vue
    │   │   │   └── HowItWorksSection.vue
    │   ├── Layouts
    │   │   ├── AdminLayout.vue
    │   │   ├── AuthenticatedLayout.vue
    │   │   ├── GuestLayout.vue
    │   │   ├── MessageLayout.vue
    │   │   ├── TrashLayout.vue
    │   │   ├── UserSettingsLayout.vue
    │   │   └── settings
    │   │   │   └── AdminSettingsLayout.vue
    │   ├── Pages
    │   │   ├── AboutUs.vue
    │   │   ├── Auth
    │   │   │   ├── ConfirmPassword.vue
    │   │   │   ├── ForgotPassword.vue
    │   │   │   ├── Login.vue
    │   │   │   ├── Register.vue
    │   │   │   ├── ResetPassword.vue
    │   │   │   └── VerifyEmail.vue
    │   │   ├── Message.vue
    │   │   ├── Privacy.vue
    │   │   ├── PrivacyInSignup.vue
    │   │   ├── Profile
    │   │   │   ├── Edit.vue
    │   │   │   └── Partials
    │   │   │   │   ├── DeleteUserForm.vue
    │   │   │   │   ├── UpdatePasswordForm.vue
    │   │   │   │   └── UpdateProfileInformationForm.vue
    │   │   ├── Settings.vue
    │   │   ├── Settings
    │   │   │   ├── admin
    │   │   │   │   ├── Announcement.vue
    │   │   │   │   ├── AnnouncementTrashed.vue
    │   │   │   │   ├── CreateAnnouncement.vue
    │   │   │   │   ├── ItemTrash.vue
    │   │   │   │   ├── NotificationTrashed.vue
    │   │   │   │   ├── Notifications.vue
    │   │   │   │   ├── Settings.vue
    │   │   │   │   ├── UserTrashed.vue
    │   │   │   │   ├── ViewTrashItem.vue
    │   │   │   │   └── ViewTrashSpecificUser.vue
    │   │   │   └── user
    │   │   │   │   ├── Announcement.vue
    │   │   │   │   ├── NotificationTrashed.vue
    │   │   │   │   └── Notifications.vue
    │   │   ├── ViewItemInfo.vue
    │   │   ├── ViewMoreUsers.vue
    │   │   ├── Welcome.vue
    │   │   ├── admin
    │   │   │   ├── ClickPendingRequest.vue
    │   │   │   ├── ContactAdmin.vue
    │   │   │   ├── Dashboard.vue
    │   │   │   ├── EditProfile.vue
    │   │   │   ├── FindMatch.vue
    │   │   │   ├── Home.vue
    │   │   │   ├── Profile.vue
    │   │   │   ├── Report.vue
    │   │   │   ├── ReportFoundItem.vue
    │   │   │   ├── TotalLostItem.vue
    │   │   │   ├── ViewItem.vue
    │   │   │   ├── ViewItemInfoAsAdmin.vue
    │   │   │   ├── ViewLostItem.vue
    │   │   │   ├── ViewPendingRequest.vue
    │   │   │   └── users
    │   │   │   │   ├── Index.vue
    │   │   │   │   ├── RecentLostAndFoundReports.vue
    │   │   │   │   └── ViewUserInfo.vue
    │   │   ├── user
    │   │   │   ├── Dashboard.vue
    │   │   │   ├── EditProfile.vue
    │   │   │   ├── Profile.vue
    │   │   │   ├── Report.vue
    │   │   │   └── ViewUserInfo.vue
    │   │   └── viewLater
    │   │   │   ├── admin
    │   │   │       └── Index.vue
    │   │   │   └── user
    │   │   │       └── Index.vue
    │   ├── app.js
    │   ├── bootstrap.js
    │   └── piniaStore
    │   │   ├── FilterChart.js
    │   │   ├── ToggleLoginButtonDisable.js
    │   │   ├── ToggleSettingsRoute.js
    │   │   └── useSidebarStore.js
    └── views
    │   └── app.blade.php
├── routes
    ├── auth.php
    ├── channels.php
    ├── console.php
    └── web.php
├── storage
    ├── app
    │   ├── .gitignore
    │   ├── private
    │   │   └── .gitignore
    │   └── public
    │   │   └── .gitignore
    ├── framework
    │   ├── .gitignore
    │   ├── cache
    │   │   ├── .gitignore
    │   │   └── data
    │   │   │   └── .gitignore
    │   ├── sessions
    │   │   └── .gitignore
    │   ├── testing
    │   │   └── .gitignore
    │   └── views
    │   │   └── .gitignore
    └── logs
    │   └── .gitignore
├── tailwind.config.js
├── tests
    ├── Feature
    │   ├── Auth
    │   │   ├── AuthenticationTest.php
    │   │   ├── EmailVerificationTest.php
    │   │   ├── PasswordConfirmationTest.php
    │   │   ├── PasswordResetTest.php
    │   │   ├── PasswordUpdateTest.php
    │   │   └── RegistrationTest.php
    │   ├── ExampleTest.php
    │   └── ProfileTest.php
    ├── TestCase.php
    └── Unit
    │   └── ExampleTest.php
├── todos.json
└── vite.config.js -->
