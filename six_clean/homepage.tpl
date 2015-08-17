{if $twitterusername}<!--1-->
  <h2>{$LANG.twitterlatesttweets}</h2>
  <div id="twitterFeedOutput"><p class="text-center"><img src="{$BASE_PATH_IMG}/loading.gif"></p></div>

  <script type="text/javascript" src="templates/{$template}/js/twitter.js"></script>
{elseif $announcements}<!--1 elseif-->
  <h2>{$LANG.news}</h2>

{foreach $announcements as $announcement}
{if $announcement@index < 2}<!--2-->
  <div class="announcement-single">
    <h3>
      <span class="label label-default">{$announcement.rawDate|date_format:"M jS"}</span>
      <a href="{if $seofriendlyurls}{$WEB_ROOT}/announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}">{$announcement.title}</a>
    </h3>
    <blockquote>
      <p>
      {if $announcement.text|strip_tags|strlen < 350}<!--3-->
        {$announcement.text}
      {else}<!--3 else-->
        {$announcement.summary}
        <a href="{if $seofriendlyurls}{$WEB_ROOT}/announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}" class="label label-warning">{$LANG.readmore} &raquo;</a>
      {/if}<!--3 end-->
      </p>
    </blockquote>

  {if $announcementsFbRecommend}<!--3-->
    <script>
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));
    </script>
 
    <div class="fb-like hidden-sm hidden-xs" data-layout="standard" data-href="{$systemurl}{if $seofriendlyurls}{$WEB_ROOT}/announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
    <div class="fb-like hidden-lg hidden-md" data-layout="button_count" data-href="{$systemurl}{if $seofriendlyurls}{$WEB_ROOT}/announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
  {/if}<!--3 end-->
  </div>
{/if}<!--2 end-->
{/foreach}
{/if}<!--1 end-->
