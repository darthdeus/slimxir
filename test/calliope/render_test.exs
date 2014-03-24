defmodule CalliopeRenderTest do
  use ExUnit.Case

  use Calliope.Render

  @haml ~s{
!!! 5
%section.container{class: "blue"}
  %article
    %h1= title
    / %h1 An important inline comment
    /[if IE]
      %h2 An Elixir Haml Parser
    #main.content
      Welcome to Calliope}

  @html Regex.replace(~r/(^\s*)|(\s+$)|(\n)/m, ~s{
    <!DOCTYPE html>
    <section class="container blue">
      <article>
        <h1><%= title %></h1>
        <!-- <h1>An important inline comment</h1> -->
        <!--[if IE]> <h2>An Elixir Haml Parser</h2> <![endif]-->
        <div id="main" class="content">
          Welcome to Calliope
        </div>
      </article>
    </section>
  }, "")

  @haml_with_args "%a{href: url}= title"

  test :render do
    assert @html == render @haml, 
    assert "<h1>This is <%= title %></h1>" == render "%h1 This is \#{title}"
  end

  test :render_with_params do
    assert "<a href='<%= url %>'><%= title %></a>" ==
      render @haml_with_args
  end

end
