local PreservedFood = Class(function(self, inst)
    self.inst = inst
    self.output = nil
    self.outputAmount = nil
end)

function PreservedFood:SetOutput(output, amount)
    self.output = output
    self.outputAmount = amount
end

function PreservedFood:Open(target)
    local i = self.outputAmount
    if target.components.inventory ~= nil then
        for k=1,i,1 do
            target.components.inventory:GiveItem(SpawnPrefab(self.output))
        end
        if self.inst.components.stackable ~= nil and self.inst.components.stackable:IsStack() then
            self.inst.components.stackable:Get():Remove()
        else
            self.inst:Remove()
        end
        return true
    end
end

return PreservedFood
