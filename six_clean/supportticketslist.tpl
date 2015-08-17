  {include file="$template/includes/tablelist.tpl" tableName="TicketsList" filterColumn="2"}
  <script type="text/javascript">
    jQuery(document).ready( function () {
      var table = $('#tableTicketsList').DataTable();
    {if $orderby == 'did' || $orderby == 'dept'}<!--1-->
      table.order(0, '{$sort}');
    {elseif $orderby == 'subject' || $orderby == 'title'}<!--1 elseif-->
      table.order(1, '{$sort}');
    {elseif $orderby == 'status'}<!--1 elseif-->
      table.order(2, '{$sort}');
    {elseif $orderby == 'lastreply'}<!--1 else-->
      table.order(3, '{$sort}');
    {/if}<!--1 end-->
      table.draw();
    });
  </script>
  <div class="table-container clearfix">
    <table id="tableTicketsList" class="table table-list">
      <thead>
        <tr>
          <th>{$LANG.supportticketsdepartment}</th>
          <th>{$LANG.supportticketssubject}</th>
          <th>{$LANG.supportticketsstatus}</th>
          <th>{$LANG.supportticketsticketlastupdated}</th>
        </tr>
      </thead>
      <tbody>
      {foreach from=$tickets item=ticket}
        <tr onclick="window.location='viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}'">
          <td class="text-center">{$ticket.department}</td>
          <td><a href="viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}">{if $ticket.unread}<strong>{/if}#{$ticket.tid} - {$ticket.subject}{if $ticket.unread}</strong>{/if}</a></td>
          <td><span class="label status {if is_null($ticket.statusColor)}status-{$ticket.statusClass}"{else}status-custom" style="border-color: {$ticket.statusColor}; color: {$ticket.statusColor}"{/if}>{$ticket.status|strip_tags}</span></td>
          <td class="text-center"><span class="hidden">{$ticket.normalisedLastReply}</span>{$ticket.lastreply}</td>
        </tr>
      {/foreach}
      </tbody>
    </table>
  </div>
