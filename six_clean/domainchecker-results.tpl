{if $validDomain}<!--1-->
{if $searchResults}<!--2-->
  <div class="domain-checker-result-headline">
  {if $searchResults.isRegistered}<!--3-->
    <p class="domain-checker-unavailable">
      {$LANG.domainunavailable1} <strong>{$searchResults.domainName}</strong> {$LANG.domainunavailable2}
    </p>
  {else}<!--3 else-->
    <p class="domain-checker-available">
      {$LANG.domainavailable1} <strong>{$searchResults.domainName}</strong> {$LANG.domainavailable2}
    </p>
  {/if}<!--3 end-->
  </div>
{/if}<!--2 end-->

{if ($searchResults && !$searchResults.isRegistered) || $bulkCheckResults}<!--2-->
  <div class="domainresults" id="primarySearchResults">
    <div id="btnCheckout" class="domain-checkout-area"><a href="cart.php?a=view" class="btn btn-default">{$LANG.domainsgotocheckout} &raquo;</a></div>
    <div>{$LANG.domainssearchresults}</div>
    <table class="table table-curved table-hover" id="searchResults">
      <tbody>

      {if $searchResults}<!--3-->
        <tr>
          <td><strong>{$searchResults.domainName}</strong></td>
          <td class="text-center"><span class="label label-success">{$LANG.domaincheckeravailable}</span></td>
          <td class="text-center">{$searchResults.shortestPeriod.register}</td>
          <td class="text-center">
            <button type="button" onclick="addToCart(this, false)" class="btn btn-primary btn-sm">
              <span class="glyphicon glyphicon-shopping-cart"></span>
              {$LANG.addtocart}
            </button>
          </td>
        </tr>
      {/if}<!--3 end-->
      
      {foreach $bulkCheckResults as $result}
        <tr>
          <td><strong>{$result.domainName}</strong></td>
          <td class="text-center">
          {if $searchingFor == 'register'}<!--3-->
          {if $result.isAvailable}<!--4-->
            <span class="label label-success">{$LANG.domaincheckeravailable}</span>
          {elseif $result.isRegistered}<!--4 elseif-->
            <span class="label label-danger">{$LANG.domaincheckertaken}</span>
          {else}<!--4 else-->
            <span class="label label-danger">Status Unknown</span>
          {/if}<!--4 end-->
          {else}<!--3 else-->
          {if $result.isRegistered}<!--4-->
            <span class="label label-success">{$LANG.domaincheckertransferable}</span>
          {elseif $result.isAvailable}<!--4 elseif-->
            <span class="label label-danger">Not Registered</span>
          {else}<!--4 else-->
            <span class="label label-danger">Status Unknown</span>
          {/if}<!--4 end-->
          {/if}<!--3 end-->
          </td>
          <td class="text-center">
          {if ($searchingFor == 'register' && $result.isAvailable) || ($searchingFor == 'transfer' && $result.isRegistered)}<!--3-->
            {$result.shortestPeriod.register}
          {/if}<!--3 end-->
          </td>
          <td class="text-center">
          {if ($searchingFor == 'register' && $result.isAvailable) || ($searchingFor == 'transfer' && $result.isRegistered)}<!--3-->
            <button type="button" onclick="addToCart(this, false)" class="btn btn-primary btn-sm">
              <span class="glyphicon glyphicon-shopping-cart"></span>
              {$LANG.addtocart}
            </button>
          {elseif $result.isRegistered}<!--3 elseif-->
            <a href="http://{$result.domainName}" target="_blank" class="btn btn-default btn-sm">www</a>
            <button type="button" onclick="viewWhois('{$result.domainName}')" class="btn btn-default btn-sm">WHOIS</button>
          {/if}<!--3 end-->
          </td>
        </tr>
      {/foreach}
      </tbody>
    </table>
  </div>
{/if}<!--2 end-->
{/if}<!--1 end-->
{if $searchResults && count($searchResults.suggestions) > 0}<!--1-->
  <div class="row">
    <div class="col-md-8 col-md-offset-2">
      <div class="domainresults" id="suggestionSearchResults">
        <div>{$LANG.domainssuggestions} <span>{$LANG.domainsothersuggestions}</span></div>
        <table class="table table-curved table-hover" id="suggestionResults">
          <tbody>
          {foreach $searchResults.suggestions as $i => $result}
            <tr{if $i >= 10} class="hidden"{/if}>
              <td><strong>{$result.domainName}</strong></td>
              <td class="text-center">{$result.shortestPeriod.register}</td>
              <td class="text-center">
                <button type="button" class="btn btn-default btn-sm" onclick="addToCart(this, true)">
                  <span class="glyphicon glyphicon-shopping-cart"></span>
                  {$LANG.addtocart}
                </button>
              </td>
            </tr>
          {/foreach}
            <tr id="trNoMoreSuggestions" class="hidden">
              <td colspan="3" class="text-muted text-center">{$LANG.domaincheckernomoresuggestions}</td>
            </tr>
          </tbody>
        </table>
      </div>
    {if $moreSuggestionsAvailable}<!--2-->
      <p class="text-center"><a href="#" class="btn btn-link" id="btnMoreSuggestions" onclick="showMoreSuggestions();return false">{$LANG.domainsmoresuggestions}</a></p>
    {/if}<!--2 end-->
      <div class="domain-disclaimer-area">
        <p class="text-muted"><strong>{$LANG.disclaimers}</strong><br />{$LANG.domainssuggestionswarnings}</p>
      </div>
    </div>
  </div>
{/if}<!--1 end-->
