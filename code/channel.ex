def join("rooms:lobby", message, socket) do
  Things.do()
  {:ok, socket}
end

…

def join("rooms:" <> _private_subtopic, _message, _socket) do
  {:error, %{reason: "unauthorized"}} 
end

…

def handle_in("new:msg", msg, socket) do
  broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"]}
  {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
end
