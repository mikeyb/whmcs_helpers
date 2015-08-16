{if $warnings}<!--1-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$warnings textcenter=true}
{/if}<!--1 end-->

  <div class="tab-content">
    <div class="tab-pane fade in active" id="tabOverview">
      {include file="$template/includes/tablelist.tpl" tableName="DomainsList" noSortColumns="0, 6" startOrderCol="1" filterColumn="5"}
      <script type="text/javascript">
        jQuery(document).ready( function () {
          var table = $('#tableDomainsList').DataTable();
        {if $orderby == 'domain'}<!--1-->
          table.order(1, '{$sort}');
        {elseif $orderby == 'regdate' || $orderby == 'registrationdate'}<!--1 elseif-->
          table.order(2, '{$sort}');
        {elseif $orderby == 'nextduedate'}<!--1 elseif-->
          table.order(3, '{$sort}');
        {elseif $orderby == 'price' || $orderby == 'recurringamount'}<!--1 elseif-->
          table.order(4, '{$sort}');
        {elseif $orderby == 'status'}<!--1 elseif-->
          table.order(5, '{$sort}');
        {/if}<!--1 end-->
          table.draw();
        });
      </script>

      <form id="domainForm" method="post" action="clientarea.php?action=bulkdomain">
        <input id="bulkaction" name="update" type="hidden">

        <div class="table-container clearfix">
          <table id="tableDomainsList" class="table table-list">
            <thead>
              <tr>
                <th width="20"></th>
                <th>{$LANG.orderdomain}</th>
                <th>{$LANG.regdate}</th>
                <th>{$LANG.nextdue}</th>
                <th>{$LANG.domainsautorenew}</th>
                <th>{$LANG.domainstatus}</th>
                <th>&nbsp;</th>
              </tr>
            </thead>
            <tbody>
            {foreach key=num item=domain from=$domains}
              <tr onclick="clickableSafeRedirect(event, 'clientarea.php?action=domaindetails&amp;id={$domain.id}', false)">
                <td><input type="checkbox" name="domids[]" class="domids stopEventBubble" value="{$domain.id}"></td>
                <td><a href="http://{$domain.domain}" target="_blank">{$domain.domain}</a></td>
                <td><span class="hidden">{$domain.normalisedRegistrationDate}</span>{$domain.registrationdate}</td>
                <td><span class="hidden">{$domain.normalisedNextDueDate}</span>{$domain.nextduedate}</td>
                <td>{$domain.amount}</td>
                <td>
                  <span class="label status status-{$domain.statusClass}">{$domain.statustext}</span>
                  <span class="hidden">
                  {if $domain.next30}<!--1-->
                    {$LANG.domainsExpiringInTheNext30Days}
                    <br>
                  {/if}<!--1 end-->
                  {if $domain.next90}<!--1-->
                    {$LANG.domainsExpiringInTheNext90Days}
                    <br>
                  {/if}<!--1 end-->
                  {if $domain.next180}<!--1-->
                    {$LANG.domainsExpiringInTheNext180Days}
                    <br>
                  {/if}<!--1 end-->
                  {if $domain.after180}<!--1-->
                    {$LANG.domainsExpiringInMoreThan180Days}
                  {/if}<!--1 end-->
                  </span>
                </td>
                <td>
                  <div class="btn-group btn-group-sm">
                    <a href="clientarea.php?action=domaindetails&id={$domain.id}" class="btn btn-default"><i class="fa fa-wrench"></i></a>
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                      <span class="caret"></span>
                      <span class="sr-only">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu text-left" role="menu">
                    {if $domain.status eq 'Active'}
                      <li><a href="clientarea.php?action=domaindetails&id={$domain.id}#tabNameservers"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainmanagens}</a></li>
                      <li><a href="clientarea.php?action=domaincontacts&domainid={$domain.id}"><i class="glyphicon glyphicon-user"></i> {$LANG.domaincontactinfoedit}</a></li>
                      <li><a href="clientarea.php?action=domaindetails&id={$domain.id}#tabAutorenew"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainautorenewstatus}</a></li>
                      <li class="divider"></li>
                    {/if}
                      <li><a href="clientarea.php?action=domaindetails&id={$domain.id}"><i class="glyphicon glyphicon-pencil"></i> {$LANG.managedomain}</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
            {/foreach}
            </tbody>
          </table>
        </div>
      </form>

      <div class="btn-group margin-bottom">
        <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
          <span class="glyphicon glyphicon-folder-open"></span> &nbsp; {$LANG.withselected} <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu">
          <li><a href="#" id="nameservers" class="setBulkAction"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainmanagens}</a></li>
          <li><a href="#" id="autorenew" class="setBulkAction"><i class="glyphicon glyphicon-refresh"></i> {$LANG.domainautorenewstatus}</a></li>
          <li><a href="#" id="reglock" class="setBulkAction"><i class="glyphicon glyphicon-lock"></i> {$LANG.domainreglockstatus}</a></li>
          <li><a href="#" id="contactinfo" class="setBulkAction"><i class="glyphicon glyphicon-user"></i> {$LANG.domaincontactinfoedit}</a></li>
        </ul>
      </div>
    </div>

    <div class="tab-pane fade in" id="tabRenew">
      {include file="$template/includes/tablelist.tpl" tableName="RenewalsList" noSortColumns="3, 4, 5" startOrderCol="0" filterColumn="1" dontControlActiveClass=true}
      <div class="table-container clearfix">
        <table id="tableRenewalsList" class="table table-list">
          <thead>
            <tr>
              <th>{$LANG.orderdomain}</th>
              <th>{$LANG.domainstatus}</th>
              <th>{$LANG.clientareadomainexpirydate}</th>
              <th>{$LANG.domaindaysuntilexpiry}</th>
              <th>&nbsp;</th>
              <th>
                <div id="btnCheckout" style="display:none;">
                  <a href="cart.php?a=view" class="btn btn-default">{$LANG.domainsgotocheckout} &raquo;</a>
                </div>
              </th>
            </tr>
          </thead>
          <tbody>
          {foreach $renewals as $id => $renewal}
            <tr id="domainRow{$renewal.id}" {if $selectedIDs && in_array($renewal.id, $selectedIDs)}class="highlight"{/if}>
              <td id="domain{$renewal.id}">{$renewal.domain}</td>
              <td id="status{$renewal.id}">
                <span class="label status status-{$renewal.statusClass}">{$renewal.status}</span>
                <span class="hidden">
                {if $renewal.next30}<!--1-->
                  {$LANG.domainsExpiringInTheNext30Days}
                  <br>
                {/if}<!--1-->
                {if $renewal.next90}
                  {$LANG.domainsExpiringInTheNext90Days}
                  <br>
                {/if}<!--1 end-->
                {if $renewal.next180}
                  {$LANG.domainsExpiringInTheNext180Days}
                  <br>
                {/if}<!--1 end-->
                {if $renewal.after180}
                  {$LANG.domainsExpiringInMoreThan180Days}
                {/if}<!--1 end-->
                </span>
              </td>
              <td id="expiry{$renewal.id}"><span class="hidden">{$renewal.normalisedExpiryDate}</span>{$renewal.expiryDate}</td>
              <td id="days{$renewal.id}" class="text-center">
              {if $renewal.daysUntilExpiry > 30}<!--1-->
                <span class="text-success">{$renewal.daysUntilExpiry} {$LANG.domainrenewalsdays}</span>
              {elseif $renewal.daysUntilExpiry > 0}<!--1 elseif-->
                <span class="text-warning">{$renewal.daysUntilExpiry} {$LANG.domainrenewalsdays}</span>
              {else}<!--1 else-->
                <span class="text-danger">{$renewal.daysUntilExpiry*-1} {$LANG.domainrenewalsdaysago}</span>
              {/if}<!--1 end-->
 
              {if $renewal.inGracePeriod}<!--1-->
                <br>
                <span class="text-danger">{$LANG.domainrenewalsingraceperiod}</span>
              {/if}<!--1 end-->
              </td>
              <td id="period{$renewal.id}" class="text-center">
              {if $renewal.beforeRenewLimit}<!--1-->
                <span class="text-danger">{$LANG.domainrenewalsbeforerenewlimit|sprintf2:$renewal.beforeRenewLimitDays}</span>
              {elseif $renewal.pastGracePeriod}<!--1 elseif-->
                <span class="textred">{$LANG.domainrenewalspastgraceperiod}</span>
              {else}<!--1 else-->
                <select id="renewalPeriod{$renewal.id}" name="renewalPeriod[{$renewal.id}]">
                {foreach $renewal.renewalOptions as $renewalOption}
                  <option value="{$renewalOption.period}">{$renewalOption.period} {$LANG.orderyears} @ {$renewalOption.price}</option>
                {/foreach}
                </select>
              {/if}<!--1 end-->
              </td>
              <td class="text-center">
              {if !$renewal.beforeRenewLimit && !$renewal.pastGracePeriod}
                <button type="button" class="btn btn-primary btn-sm" id="renewButton{$renewal.id}" onclick="addRenewalToCart({$renewal.id}, this)">
                  <span class="glyphicon glyphicon-shopping-cart"></span> {$LANG.addtocart}
                </button>
              {/if}
              </td>
            </tr>
          {/foreach}
          </tbody>
        </table>
      </div>

      <div class="row">
        <div class="col-xs-12" id="backLink">
          <a href="#tabOverview" class="btn btn-default btn-sm" data-toggle="tab" id="back">
            <i class="glyphicon glyphicon-backward"></i> {$LANG.clientareabacklink|replace:'&laquo; ':''}
          </a>
        </div>
      </div>
    </div>
  </div>
