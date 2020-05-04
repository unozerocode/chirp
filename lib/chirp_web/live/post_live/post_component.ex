defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~L"""
      <div id="post-<%= @post.id %>" class="post" style="border:1px solid gray;border-radius: 4px; padding: 1rem; margin: 1rem;">
        <div class="row ">
          <div class="column column-10">
            <div class="post-avatar">

            </div>
          </div>
          <div class="column column-90 post-body">
            <span class="user_name">@<%= @post.username %></span>
            <br>
            <p><%= @post.body %></p>
          </div>
        </div>
        <div class="row actions_bar">
          <div class="column column-33 text-center">
          <a href="#" phx-click="like" phx-target="<%= @myself %>">
              <i class="fa fa-heart"></i> <%= @post.likes_count %>
    </a>
          </div>
          <div class="column column-33 text-center">
          <a href="#" phx-click="repost" phx-target="<%= @myself %>">
              <i class="fa fa-retweet"></i> <%= @post.reposts_count %>
              </a>
          </div>
          <div class="column column-33 text-center">
            <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
              <i class="far fa-edit"></i>
            <% end %>

            <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
              <i class="fa fa-trash-alt"></i>
            <% end %>
          </div>
        </div>
      </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreplay, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreplay, socket}
  end
end
