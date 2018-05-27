void yell(String s) {
  URL icon = null;

        try {icon = new URL("http://www.icontester.com/assets/images/ico_android.png");} catch(Exception e) {}

        Application application = Application.builder()
            .id("systemtray-example")
            .name("SystemTray Example")
            .icon(Icon.create(icon, "app"))
            .timeout(2000)
            .build();

        Notifier notifier = new SendNotification()
                .setApplication(application)
                .setChosenNotifier("systemtray")
                .initNotifier();

        Notification notification = Notification.builder()
            .title("SystemTray Notification")
            .message(s)
            .icon(Icon.create(icon, "ok"))
            .build();

        notifier.send(notification);
        notifier.close();
}
