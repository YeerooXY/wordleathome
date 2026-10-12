package com.yeeroo.ourword;

import android.app.Activity;
import android.os.Bundle;
import android.net.Uri;
import android.graphics.Color;
import android.view.Gravity;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import androidx.browser.customtabs.CustomTabsIntent;
import androidx.browser.customtabs.CustomTabColorSchemeParams;

public final class MainActivity extends Activity {
    private static final Uri GAME = Uri.parse("https://our-word-household.nemozoli.chatgpt.site");
    @Override public void onCreate(Bundle state) {
        super.onCreate(state);
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setGravity(Gravity.CENTER);
        layout.setPadding(40, 40, 40, 40);
        layout.setBackgroundColor(Color.rgb(245, 243, 236));
        TextView title = new TextView(this);
        title.setText("Our Word"); title.setTextSize(36); title.setTextColor(Color.rgb(40, 59, 50));
        layout.addView(title);
        TextView subtitle = new TextView(this);
        subtitle.setText("A little word. A familiar rivalry."); subtitle.setPadding(0, 24, 0, 40);
        layout.addView(subtitle);
        Button play = new Button(this); play.setText("Play with your household");
        play.setOnClickListener(view -> openGame()); layout.addView(play);
        setContentView(layout);
        if (state == null) openGame();
    }
    private void openGame() {
        CustomTabsIntent tab = new CustomTabsIntent.Builder()
            .setDefaultColorSchemeParams(new CustomTabColorSchemeParams.Builder().setToolbarColor(Color.rgb(245, 243, 236)).build())
            .setShowTitle(true).setUrlBarHidingEnabled(true).build();
        try { tab.launchUrl(this, GAME); }
        catch (android.content.ActivityNotFoundException exception) {
            Toast.makeText(this, "Install a browser to open your household game.", Toast.LENGTH_LONG).show();
        }
    }
}
