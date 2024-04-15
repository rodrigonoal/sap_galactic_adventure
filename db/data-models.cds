namespace btp.spacefarers;

using {
    cuid,
    managed
} from '@sap/cds/common';

@assert.unique: {email: [email]}

entity GalacticSpacefarers                                @(Capabilities: {
    InsertRestrictions.Insertable: true,
    UpdateRestrictions.Updatable : true,
    DeleteRestrictions.Deletable : true
}) : cuid, managed {
    name                    : String(255)                 @mandatory  @Core.Immutable;
    email                   : String(255)                 @mandatory  @Core.Immutable;
    department              : Association to one Departments          @mandatory  @Core.Immutable  @assert.target;
    position                : Association to one Positions            @mandatory  @Core.Immutable  @assert.target;
    originPlanet            : String(255)                 @mandatory  @Core.Immutable;
    spacesuitColor          : String(255) default 'White' @mandatory;
    stardustCollection      : UInt8 default 0             @mandatory;
    wormholeNavigationSkill : Integer                     @mandatory  @Core.Immutable  @assert.range  enum {
        none          = 0;
        very_weak     = 1;
        weak          = 2;
        below_average = 3;
        average       = 4;
        above_average = 5;
        good          = 6;
        very_good     = 7;
        excellent     = 8;
        outstanding   = 9;
        master        = 10;
    } default 0;
}

entity Departments : cuid, managed {
    name        : String(255) @mandatory;
    spacefarers : Association to many GalacticSpacefarers
                      on spacefarers.department = $self;
    positions   : Association to many Positions
                      on positions.department = $self;
}

entity Positions : cuid, managed {
    name        : String(255) @mandatory;
    department  : Association to one Departments  @mandatory  @assert.target;
    spacefarers : Association to many GalacticSpacefarers
                      on spacefarers.position = $self;
}
