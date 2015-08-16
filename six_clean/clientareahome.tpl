  <div class="tiles clearfix">
    <div class="row">
      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='clientarea.php?action=services'">
        <a href="clientarea.php?action=services">
          <div class="icon"><i class="fa fa-cube"></i></div>
          <div class="stat">{$clientsstats.productsnumactive}</div>
          <div class="title">{$LANG.navservices}</div>
          <div class="highlight bg-color-blue"></div>
        </a>
      </div>
    {if $registerdomainenabled || $transferdomainenabled}<!--1-->
      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='clientarea.php?action=domains'">
        <a href="clientarea.php?action=domains">
          <div class="icon"><i class="fa fa-globe"></i></div>
          <div class="stat">{$clientsstats.numactivedomains}</div>
          <div class="title">{$LANG.navdomains}</div>
          <div class="highlight bg-color-green"></div>
        </a>
      </div>
    {elseif $condlinks.affiliates && $clientsstats.isAffiliate}<!--1 elseif-->
      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='affiliates.php'">
        <a href="affiliates.php">
          <div class="icon"><i class="fa fa-shopping-cart"></i></div>
          <div class="stat">{$clientsstats.numaffiliatesignups}</div>
          <div class="title">{$LANG.affiliatessignups}</div>
          <div class="highlight bg-color-green"></div>
        </a>
      </div>
    {else}<!--1 else-->
      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='clientarea.php?action=quotes'">
        <a href="clientarea.php?action=quotes">
          <div class="icon"><i class="fa fa-file-text-o"></i></div>
          <div class="stat">{$clientsstats.numquotes}</div>
          <div class="title">{$LANG.quotes}</div>
          <div class="highlight bg-color-green"></div>
        </a>
      </div>
    {/if}<!--1 end-->
      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='supporttickets.php'">
        <a href="supporttickets.php">
          <div class="icon"><i class="fa fa-comments"></i></div>
          <div class="stat">{$clientsstats.numactivetickets}</div>
          <div class="title">{$LANG.navtickets}</div>
          <div class="highlight bg-color-red"></div>
        </a>
      </div>

      <div class="col-sm-3 col-xs-6 tile" onclick="window.location='clientarea.php?action=invoices'">
        <a href="clientarea.php?action=invoices">
          <div class="icon"><i class="fa fa-credit-card"></i></div>
          <div class="stat">{$clientsstats.numunpaidinvoices}</div>
          <div class="title">{$LANG.navinvoices}</div>
          <div class="highlight bg-color-gold"></div>
        </a>
      </div>
    </div>
  </div>

  <form role="form" method="post" action="clientarea.php?action=kbsearch">
    <div class="row">
      <div class="col-md-12 home-kb-search">
        <input type="text" name="search" class="form-control input-lg" placeholder="{$LANG.clientHomeSearchKb}" /> <i class="fa fa-search"></i>
      </div>
    </div>
  </form>

{foreach from=$addons_html item=addon_html}
  <div>{$addon_html}</div>
{/foreach}

  <div class="client-home-panels">
    <div class="row">
      <div class="col-sm-6">

      {function name=outputHomePanels}
        <div menuItemName="{$item->getName()}" class="panel panel-default panel-accent-{$item->getExtra('color')}{if $item->getClass()} {$item->getClass()}{/if}"{if $item->getAttribute('id')} id="{$item->getAttribute('id')}"{/if}>
          <div class="panel-heading">
            <h3 class="panel-title">
            {if $item->getExtra('btn-link') && $item->getExtra('btn-text')}<!--1-->
              <div class="pull-right">
                <a href="{$item->getExtra('btn-link')}" class="btn btn-default bg-color-{$item->getExtra('color')} btn-xs">
                {if $item->getExtra('btn-icon')}<!--2-->
                  <i class="fa {$item->getExtra('btn-icon')}"></i>
                {/if}<!--2 end-->
                  {$item->getExtra('btn-text')}
                </a>
              </div>
            {/if}<!--1 end-->

            {if $item->hasIcon()}<!--1-->
              <i class="{$item->getIcon()}"></i>&nbsp;
            {/if}<!--1 end-->

            {$item->getLabel()}
            {if $item->hasBadge()}<!--1-->
              &nbsp;<span class="badge">{$item->getBadge()}</span>
            {/if}<!--1 end-->
            </h3>
          </div>
        {if $item->hasBodyHtml()}<!--1-->
          <div class="panel-body">{$item->getBodyHtml()}</div>
        {/if}<!--1 end-->

        {if $item->hasChildren()}<!--1-->
          <div class="list-group{if $item->getChildrenAttribute('class')} {$item->getChildrenAttribute('class')}{/if}">
          {foreach $item->getChildren() as $childItem}
          {if $childItem->getUri()}<!--2-->
            <a menuItemName="{$childItem->getName()}" href="{$childItem->getUri()}" class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}{if $childItem->isCurrent()} active{/if}"{if $childItem->getAttribute('dataToggleTab')} data-toggle="tab"{/if}{if $childItem->getAttribute('target')} target="{$childItem->getAttribute('target')}"{/if} id="{$childItem->getId()}">
            {if $childItem->hasIcon()}<!--3-->
              <i class="{$childItem->getIcon()}"></i>&nbsp;
            {/if}<!--3 end-->
            {$childItem->getLabel()}
            {if $childItem->hasBadge()}<!--3-->
              &nbsp;<span class="badge">{$childItem->getBadge()}</span>
            {/if}<!--3 end-->
            </a>
          {else}<!--2 else-->
            <div menuItemName="{$childItem->getName()}" class="list-group-item{if $childItem->getClass()} {$childItem->getClass()}{/if}" id="{$childItem->getId()}">
            {if $childItem->hasIcon()}<!--3-->
              <i class="{$childItem->getIcon()}"></i>&nbsp;
            {/if}<!--3 end-->
              {$childItem->getLabel()}
            {if $childItem->hasBadge()}<!--3-->
              &nbsp;<span class="badge">{$childItem->getBadge()}</span>
            {/if}<!--3 end-->
            </div>
          {/if}<!--2 end-->
          {/foreach}
          </div>
        {/if}<!--1 end-->

          <div class="panel-footer">
          {if $item->hasFooterHtml()}<!--1-->
            {$item->getFooterHtml()}
          {/if}<!--1 end-->
          </div>
        </div>
      {/function}

      {foreach $panels as $item}
      {if $item@iteration is odd}<!--1-->
        {outputHomePanels}
      {/if}<!--1 end-->
      {/foreach}

      </div>

      <div class="col-sm-6">

      {foreach $panels as $item}
      {if $item@iteration is even}<!--1-->
        {outputHomePanels}
      {/if}<!--1 end-->
      {/foreach}

      </div>
    </div>
  </div>
