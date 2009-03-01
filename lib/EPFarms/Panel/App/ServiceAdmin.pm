package EPFarms::Panel::App::ServiceAdmin;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_services',
  title => 'Services Admin',
  icon => 'img/famfam/icons/cog.png',
  user_group => 'paneldev',
}});

has db => (is => 'rw');

sub main {
  my ($self) = @_;
  my ($username, $password) = $self->get_mysql_auth;
  return unless $username;
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );
  $self->db($db);
  do {
    my $out = "
    <h2>Service Administrator</h2>
    <p>This is where you can edit the metadata for the services we provide. You
    probably won't need to do that very often!</p>
    <table border=0 cellspacing=0 cellpadding=4 class=\"data\">
      <thead>
        <tr class=header>
          <th>Service</th>
          <th>Bill Period</th>
          <th>Bill Amount</th>
          <th>Actions</th>
        </tr>
      </thead>";
    foreach my $service ($db->resultset('Service')->search) {
      my $edit_link = $self->add_link("Edit" =>
        sub { $self->edit_service($service) });
      $out .= "<tr><td>"
        . $self->add_link($service->name => sub { $self->service_detail($service) })
        . "</td>"
        . "<td>"
        . $service->bill_period
        . "</td>"
        . "<td>"
        . $service->bill_amount
        . "</td>"
        . "<td>"
        . $edit_link
        . "</td></tr>";
    }
    $out .= "</table>";
    $out .= $self->add_link("Add new service" => sub { $self->create_service });

    $self->display($out);
  } while $self->process_links;
}


sub service_detail {
  my ($self, $service) = @_;
  my $do_exit = 0;
  do {
    my $out = qq|
      <h2>Service: @{[$service->name]}</h2>
      Bill Period: @{[$service->bill_period]}<br>
      Bill Amount: \$@{[$service->bill_amount]}<br>
    |;
    if(scalar ($service->details) > 0) {
      $out .= qq|
        <h4>Fields:</h4>
        <table border=0 cellspacing=0 cellpadding=4 class="data">
          <thead>
            <tr class=header>
              <th>Name</th>
              <th>Required?</th>
              <th>Type</th>
              <th>Default</th>
              <th>Actions</th>
            </tr>
          </thead>
      |;
      foreach my $field ($service->details) {
        my $edit_link = $self->add_link("Edit" =>
          sub { $self->edit_service_detail($field) });
        my $delete_link = $self->add_link("Delete" =>
          sub { $field->delete });
        $out .= qq|
          <tr>
            <td>@{[$field->name]}</td>
            <td>@{[$field->is_required]}</td>
            <td>@{[$field->type]}</td>
            <td>@{[$field->default_value]}&nbsp;</td>
            <td>$edit_link $delete_link</td>
          </tr>
        |;
      }
      $out .= "</table>";
    }
    $out .= $self->add_link("Add new field" => sub { $self->create_service_detail($service) });
    $out .= "<br><br>";
    $out .= $self->add_link("Return" => sub {
      $do_exit = 1;
    });
    $self->display($out);
  } while $self->process_links && !$do_exit;
}

sub edit_service_detail {
  my ($self, $service_detail) = @_;
  #do {
    my $out = qq|
      <h2>Service Field: @{[$service_detail->name]}</h2>
      Name: @{[ $service_detail->html_text_input('name') ]}<br>
      Required? @{[ $service_detail->html_checkbox('is_required',['NO','YES']) ]}<br>
      Type: @{[ $service_detail->html_text_input('type') ]}<br>
      Default: @{[ $service_detail->html_text_input('default_value') ]}<br>
      <input type=submit name=save value="Save Changes">
      <input type=submit name=cancel value="Cancel">
    |;
    $self->display($out);
    if($self->param('save')) {
      $service_detail->html_update_text('name', $self->param);
      $service_detail->html_update_checkbox('is_required' => ['NO','YES'], $self->param);
      $service_detail->html_update_text('type', $self->param);
      $service_detail->html_update_text('default_value', $self->param);
      $service_detail->update;
    }
  #} while $self->process_links;
}

sub create_service_detail {
  my ($self, $service) = @_;
  my $service_detail = $self->db->resultset('ServiceDetail')->create({});
  $service_detail->service($service);
  return $self->edit_service_detail($service_detail);
}

sub edit_service{
  my ($self, $service) = @_;
  #do {
    my $out = qq|
      Name: @{[ $service->html_text_input('name') ]}<br>
      Bill Period: @{[ $service->html_text_input('bill_period') ]}<br>
      Bill Amount: @{[ $service->html_text_input('bill_amount') ]}<br>
      <input type=submit name=save value="Save Changes">
      <input type=submit name=cancel value="Cancel">
    |;
    $self->display($out);
    if($self->param('save')) {
      $service->html_update_text('name', $self->param);
      $service->html_update_text('bill_period', $self->param);
      $service->html_update_text('bill_amount', $self->param);
      $service->update;
    }
  #} while $self->process_links;
}

sub create_service{
  my ($self) = @_;
  my $service = $self->db->resultset('Service')->create({});
  return $self->edit_service($service);
}


1;

