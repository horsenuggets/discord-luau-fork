local application = require("@self/application")
local applicationRoleConnectionMetadata = require("@self/applicationRoleConnectionMetadata")
local auditLog = require("@self/auditLog")
local autoModeration = require("@self/autoModeration")
local emoji = require("@self/emoji")
local gateway = require("@self/gateway")
local invite = require("@self/invite")
local poll = require("@self/poll")
local request = require("@self/request")
local stageInstance = require("@self/stageInstance")
local voice = require("@self/voice")

local channel = require("@self/channel")
local commands = require("@self/commands")
local guild = require("@self/guild")
local guildScheduledEvent = require("@self/guildScheduledEvent")
local guildTemplate = require("@self/guildTemplate")
local interaction = require("@self/interaction")
local message = require("@self/message")
local sticker = require("@self/sticker")
local user = require("@self/user")
local webhook = require("@self/webhook")

export type Request = request.Request

--[=[
	@class Rest

	Interface for the discord-luau Rest package

	Rest represents all possible Discord HTTP APIs, the goal for this package is to simplify the process of making a
	request to the discord API.
]=]

return {
    --[=[
		@prop interaction Rest.interaction
		@within Rest
	]=]
    interaction = interaction,

    --[=[
		@prop poll Rest.poll
		@within Rest
	]=]
    poll = poll,

    --[=[
		@prop voice Rest.voice
		@within Rest
	]=]
    voice = voice,

    --[=[
		@prop auditLog Rest.auditLog
		@within Rest
	]=]
    auditLog = auditLog,

    --[=[
		@prop autoModeration Rest.autoModeration
		@within Rest
	]=]
    autoModeration = autoModeration,

    --[=[
		@prop message Rest.message
		@within Rest
	]=]
    message = message,

    --[=[
		@prop request Rest.Request
		@within Rest
	]=]
    request = request,

    --[=[
		@prop guildScheduledEvent Rest.guildScheduledEvent
		@within Rest
	]=]
    guildScheduledEvent = guildScheduledEvent,

    --[=[
		@prop application Rest.application
		@within Rest
	]=]
    application = application,

    --[=[
		@prop channel Rest.channel
		@within Rest
	]=]
    channel = channel,

    --[=[
		@prop user Rest.user
		@within Rest
	]=]
    user = user,

    --[=[
		@prop guildTemplate Rest.guildTemplate
		@within Rest
	]=]
    guildTemplate = guildTemplate,

    --[=[
		@prop sticker Rest.sticker
		@within Rest
	]=]
    sticker = sticker,

    --[=[
		@prop commands Rest.commands
		@within Rest
	]=]
    commands = commands,

    --[=[
		@prop stageInstance Rest.stageInstance
		@within Rest
	]=]
    stageInstance = stageInstance,

    --[=[
		@prop webhook Rest.webhook
		@within Rest
	]=]
    webhook = webhook,

    --[=[
		@prop emoji Rest.emoji
		@within Rest
	]=]
    emoji = emoji,

    --[=[
		@prop gateway Rest.gateway
		@within Rest
	]=]
    gateway = gateway,

    --[=[
		@prop invite Rest.invite
		@within Rest
	]=]
    invite = invite,

    --[=[
		@prop applicationRoleConnectionMetadata Rest.applicationRoleConnectionMetadata
		@within Rest
	]=]
    applicationRoleConnectionMetadata = applicationRoleConnectionMetadata,

    --[=[
		@prop guild Rest.guild
		@within Rest
	]=]
    guild = guild,
}
