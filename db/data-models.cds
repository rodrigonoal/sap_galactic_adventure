namespace btp.spacefarers;

using {
    cuid,
    managed
} from '@sap/cds/common';

@assert.unique: {email: [email]}

entity GalacticSpacefarers                      @(Capabilities: {
    InsertRestrictions.Insertable: true,
    UpdateRestrictions.Updatable : true,
    DeleteRestrictions.Deletable : true
}) : cuid, managed {
    name                    : String(255)       @mandatory;
    email                   : String(255)       @mandatory;
    department              : Association to one Departments  @mandatory  @assert.target;
    position                : Association to one Positions    @mandatory  @assert.target;
    originPlanet            : String(255)       @mandatory;
    spacesuitColor          : String(255)       @mandatory;
    stardustCollection      : Integer default 0;
    wormholeNavigationSkill : Integer default 0 @assert.range: [
        0,
        10
    ];

}

entity Departments : cuid, managed @(Capabilities : {
    InsertRestrictions.Insertable : true, UpdateRestrictions.Updatable : true, DeleteRestrictions.Deletable : true
}) {
    name : String(255)

@mandatory;
spacefarers : Association to many GalacticSpacefarers on spacefarers.department = $self;
positions : Association to many Positions on positions.department = $self;
}

entity Positions : cuid, managed @(Capabilities : {
InsertRestrictions.Insertable : true, UpdateRestrictions.Updatable : true, DeleteRestrictions.Deletable : true
}) {
name : String(255)@mandatory;
department : Association to one Departments @mandatory @assert.target;
spacefarers : Association to many GalacticSpacefarers on spacefarers.position = $self;
}
