{foreach from=$tweets key=num item=tweet}
{if $num < $numtweets}<!--1-->
  <div class="tweet">
    <i class="fa fa-twitter fa-2x"></i>
    <p>{$tweet.tweet} <span>{$tweet.date}</span></p>
  </div>
{/if}<!--1 end-->
{/foreach}

<p>{$LANG.twitterfollowus} @ <a href="http://twitter.com/{$twitterusername}" target="_blank">http://twitter.com/{$twitterusername}</a> to be kept up to date with all our latest news &amp; offers</p>
